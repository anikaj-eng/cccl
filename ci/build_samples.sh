#!/usr/bin/env bash

# Build the CCCL samples (samples/) using the CCCL CI environment.
#
# Samples live in a standalone CMake project (samples/CMakeLists.txt with its
# own `project()`), so we bypass CCCL's CMake preset machinery and drive
# cmake+ninja directly. Sourcing build_common.sh still gives us BUILD_DIR,
# PARALLEL_LEVEL, and the standardized CXX / CUDACXX toolchain settings.

set -eo pipefail

# shellcheck source=ci/build_common.sh
source "$(dirname "${BASH_SOURCE[0]}")/build_common.sh"

print_environment_details

# Install GL/GLUT/GLEW system dependencies needed to build the GL-based
# samples (particles, marchingCubes, smokeParticles).
run_command "Install samples system dependencies" \
    "$(dirname "${BASH_SOURCE[0]}")/install_samples_deps.sh"

SAMPLES_SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../samples" && pwd)"
SAMPLES_BUILD_DIR="${BUILD_DIR}/samples"

CMAKE_OPTIONS=(
    -S "${SAMPLES_SRC_DIR}"
    -B "${SAMPLES_BUILD_DIR}"
    -G Ninja
    -DCMAKE_CXX_STANDARD="${CXX_STANDARD}"
    -DCMAKE_CUDA_STANDARD="${CXX_STANDARD}"
    # Build against the surrounding CCCL checkout rather than fetching via CPM.
    -DCCCL_SOURCE_DIR="$(cd "${SAMPLES_SRC_DIR}/.." && pwd)"
)

# If the caller passed -arch via build_common.sh, forward it as CUDA archs.
# CUDA_ARCHS is set by build_common.sh; may be empty (use sample defaults).
if [[ -n "${CUDA_ARCHS:-}" ]]; then
    CMAKE_OPTIONS+=(-DCMAKE_CUDA_ARCHITECTURES="${CUDA_ARCHS}")
fi

run_command "CMake configure samples" \
    cmake "${CMAKE_OPTIONS[@]}" "${GLOBAL_CMAKE_OPTIONS[@]}"

run_command "Build samples" \
    cmake --build "${SAMPLES_BUILD_DIR}" --parallel "${CMAKE_BUILD_PARALLEL_LEVEL}"

run_command "Install samples" \
    cmake --install "${SAMPLES_BUILD_DIR}"

print_time_summary
