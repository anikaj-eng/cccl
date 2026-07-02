#!/usr/bin/env bash

# Run the built CCCL samples via samples/run_tests.py, which discovers all
# installed executables under the samples install prefix and invokes each
# one (with per-sample argument overrides in samples/test_args.json).
#
# This must run after ci/build_samples.sh (which populates the install tree).

set -eo pipefail

# shellcheck source=ci/build_common.sh
source "$(dirname "${BASH_SOURCE[0]}")/build_common.sh"

print_environment_details

fail_if_no_gpu

SAMPLES_SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../samples" && pwd)"
SAMPLES_BUILD_DIR="${BUILD_DIR}/samples"

# InstallSamples.cmake defaults CMAKE_INSTALL_PREFIX to
# ${SAMPLES_BUILD_DIR}/bin and then installs to
# ${prefix}/${TARGET_ARCH}/${TARGET_OS}/${BUILD_TYPE}.
SAMPLES_INSTALL_ROOT="${SAMPLES_BUILD_DIR}/bin"

if [[ ! -d "${SAMPLES_INSTALL_ROOT}" ]]; then
    echo "Samples install directory not found: ${SAMPLES_INSTALL_ROOT}" >&2
    echo "   Did ci/build_samples.sh run successfully first?" >&2
    exit 1
fi

TEST_RESULTS_DIR="${SAMPLES_BUILD_DIR}/test-results"
mkdir -p "${TEST_RESULTS_DIR}"

run_command "Run samples" \
    python3 "${SAMPLES_SRC_DIR}/run_tests.py" \
        --dir "${SAMPLES_INSTALL_ROOT}" \
        --config "${SAMPLES_SRC_DIR}/test_args.json" \
        --output "${TEST_RESULTS_DIR}" \
        --parallel 4

print_time_summary
