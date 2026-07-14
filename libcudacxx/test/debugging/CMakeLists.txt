find_program(LIBCUDACXX_GDB_EXECUTABLE NAMES gdb)
find_program(LIBCUDACXX_LLDB_EXECUTABLE NAMES lldb)

set(gdb_default OFF)
if (LIBCUDACXX_GDB_EXECUTABLE)
  set(gdb_default ON)
endif()
option(
  LIBCUDACXX_ENABLE_GDB_TESTING
  "Run libcudacxx pretty-printer tests with GDB"
  ${gdb_default}
)

set(lldb_default OFF)
if (LIBCUDACXX_LLDB_EXECUTABLE)
  set(lldb_default ON)
endif()
option(
  LIBCUDACXX_ENABLE_LLDB_TESTING
  "Run libcudacxx pretty-printer tests with LLDB"
  ${lldb_default}
)

if (LIBCUDACXX_ENABLE_GDB_TESTING AND NOT LIBCUDACXX_GDB_EXECUTABLE)
  message(
    FATAL_ERROR
    "LIBCUDACXX_ENABLE_GDB_TESTING is enabled, but GDB was not found"
  )
endif()
if (LIBCUDACXX_ENABLE_LLDB_TESTING AND NOT LIBCUDACXX_LLDB_EXECUTABLE)
  message(
    FATAL_ERROR
    "LIBCUDACXX_ENABLE_LLDB_TESTING is enabled, but LLDB was not found"
  )
endif()

set(
  debugging_test_driver
  "${CMAKE_CURRENT_SOURCE_DIR}/run_pretty_printer_test.py"
)
set(
  libcudacxx_gdb_formatter_init
  "${libcudacxx_SOURCE_DIR}/share/gdb/__init__.py"
)
set(
  libcudacxx_lldb_formatter_init
  "${libcudacxx_SOURCE_DIR}/share/lldb/__init__.py"
)

#[=======================================================================[.rst:
libcudacxx_add_pretty_printer_test
---------------------------------

Build a CUDA pretty-printer scenario and register its enabled debugger tests.

The function creates the executable target
``libcudacxx.test.debugging.<NAME>`` with host debug information and optimization
disabled. For each enabled debugger, it registers a serial CTest named
``libcudacxx.test.debugging.<debugger>.<NAME>``. The test uses the debugger's
formatter entry point and the ``<debugger>.expected`` file in the caller's source
directory.

Arguments
^^^^^^^^^

``NAME``
  Scenario name used in the executable target, CTest names, and diagnostic output.

``SOURCES``
  Source files used to build the CUDA scenario executable. Relative paths are resolved
  against the caller's source directory.

``CASES``
  Ordered runner arguments describing the debugger stops and expressions. Each case
  has the form ``--case <breakpoint> <caller-frame-index> <section-name>
  <expression>``.

#]=======================================================================]
function(libcudacxx_add_pretty_printer_test)
  set(options)
  set(one_value_arguments NAME)
  set(multi_value_arguments SOURCES CASES)
  cmake_parse_arguments(
    pretty_printer
    "${options}"
    "${one_value_arguments}"
    "${multi_value_arguments}"
    ${ARGN}
  )

  if (pretty_printer_UNPARSED_ARGUMENTS)
    message(
      FATAL_ERROR
      "Unrecognized arguments: ${pretty_printer_UNPARSED_ARGUMENTS}"
    )
  endif()
  if (NOT pretty_printer_NAME)
    message(FATAL_ERROR "libcudacxx_add_pretty_printer_test requires NAME")
  endif()
  if (NOT pretty_printer_SOURCES)
    message(FATAL_ERROR "libcudacxx_add_pretty_printer_test requires SOURCES")
  endif()
  if (NOT pretty_printer_CASES)
    message(FATAL_ERROR "libcudacxx_add_pretty_printer_test requires CASES")
  endif()

  set(target_name "libcudacxx.test.debugging.${pretty_printer_NAME}")
  cccl_add_executable(
    ${target_name}
    DIALECT 17
    NO_CLANG_TIDY
    SOURCES ${pretty_printer_SOURCES}
  )
  target_compile_options(
    ${target_name}
    PRIVATE $<$<COMPILE_LANGUAGE:CUDA>:-g> $<$<COMPILE_LANGUAGE:CUDA>:-O0>
  )
  target_link_libraries(${target_name} PRIVATE libcudacxx.compiler_interface)

  foreach (debugger IN ITEMS lldb gdb)
    string(TOUPPER "${debugger}" debugger_upper)
    set(enabled_variable "LIBCUDACXX_ENABLE_${debugger_upper}_TESTING")
    if (${enabled_variable})
      set(executable_variable "LIBCUDACXX_${debugger_upper}_EXECUTABLE")
      set(formatter_variable "libcudacxx_${debugger}_formatter_init")
      set(
        test_name
        "libcudacxx.test.debugging.${debugger}.${pretty_printer_NAME}"
      )
      add_test(
        NAME ${test_name}
        COMMAND
          "${Python_EXECUTABLE}" "${debugging_test_driver}" --debugger
          "${debugger}" --debugger-executable "${${executable_variable}}"
          --program "$<TARGET_FILE:${target_name}>" --formatter-init
          "${${formatter_variable}}" --expected
          "${CMAKE_CURRENT_SOURCE_DIR}/${debugger}.expected" --output-log
          "${CMAKE_CURRENT_BINARY_DIR}/${debugger}.log" ${pretty_printer_CASES}
      )
      set_tests_properties(${test_name} PROPERTIES RUN_SERIAL ON TIMEOUT 120)
    endif()
  endforeach()
endfunction()

add_subdirectory(buffer)
add_subdirectory(memory_resource)
