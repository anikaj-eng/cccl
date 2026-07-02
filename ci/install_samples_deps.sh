#!/usr/bin/env bash

# Install system dependencies needed by the CCCL samples (both to build and to
# run the GL-based samples: particles, marchingCubes, smokeParticles).
#
# Called from ci/build_samples.sh AND ci/test_samples.sh because each
# `launch.sh` invocation spawns a fresh container from the base image, so
# runtime shared libraries installed during build are not present at test
# time.

set -euo pipefail

if ! command -v apt-get &>/dev/null; then
    echo "Skipping samples deps install (apt-get not found)."
    exit 0
fi

SUDO=""
if [[ "${EUID}" -ne 0 ]]; then
    if command -v sudo &>/dev/null; then
        SUDO="sudo"
    else
        echo "Skipping samples deps install (no root privileges and no sudo)."
        exit 0
    fi
fi

packages=(
    # OpenGL + GLUT + GLEW dev packages, required by the particles /
    # marchingCubes / smokeParticles samples. Each -dev package Depends
    # on its matching runtime shared library (libglut3.12 / libglew2.2 /
    # libglu1-mesa / libgl1 / libglx0) so installing -dev is enough for
    # both build and test time.
    freeglut3-dev
    libglew-dev
    libglu1-mesa-dev
    libxi-dev
    libxmu-dev
)

${SUDO} apt-get update -qq
DEBIAN_FRONTEND=noninteractive \
    ${SUDO} apt-get install -y --no-install-recommends "${packages[@]}"
