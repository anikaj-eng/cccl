#!/usr/bin/env python3
# Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES. ALL RIGHTS RESERVED.
#
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

"""
Pytest driver for the CCCL sample scripts under ``samples/python/``.

Each ``*.py`` under this directory (excluding ``Utilities/`` and this file
itself) is discovered automatically and executed as a subprocess. The
sample's exit code determines pass/fail: ``0`` is a pass, ``2`` (the
``EXIT_WAIVED`` convention used by ``samples/run_tests.py``) is a skip,
anything else fails the test.

The whole module is skipped when the environment cannot run the samples:
``cuda-cccl`` is unavailable, or no NVIDIA GPU is visible via
``nvidia-smi``. This keeps the tests useful in CI without adding
CPU-only failure noise on developer machines.
"""

from __future__ import annotations

import os
import shutil
import subprocess
import sys
from pathlib import Path

import pytest

SAMPLES_PYTHON_DIR = Path(__file__).parent
EXCLUDE_DIRS = {"Utilities", "__pycache__"}
EXIT_WAIVED = 2


def _cuda_compute_importable() -> bool:
    """True when the `cuda.compute` module is available in this env."""
    try:
        import cuda.compute  # noqa: F401
    except Exception:
        return False
    return True


def _gpu_available() -> bool:
    """True when nvidia-smi reports at least one GPU."""
    nvsmi = shutil.which("nvidia-smi")
    if not nvsmi:
        return False
    try:
        result = subprocess.run(
            [nvsmi, "-L"],
            check=False,
            capture_output=True,
            text=True,
            timeout=10,
        )
    except Exception:
        return False
    if result.returncode != 0:
        return False
    return any(
        line.strip().lower().startswith("gpu ") for line in result.stdout.splitlines()
    )


def _discover_samples() -> list[Path]:
    """Return a sorted list of sample script paths."""
    samples: list[Path] = []
    for path in SAMPLES_PYTHON_DIR.rglob("*.py"):
        if path.name == Path(__file__).name:
            continue
        if any(
            part in EXCLUDE_DIRS for part in path.relative_to(SAMPLES_PYTHON_DIR).parts
        ):
            continue
        # Skip package init files.
        if path.name == "__init__.py":
            continue
        samples.append(path)
    return sorted(samples)


_SAMPLE_PATHS = _discover_samples()


def _sample_id(path: Path) -> str:
    """Human-readable pytest id: ``cuda.compute/binarySearch/binarySearch.py``."""
    return str(path.relative_to(SAMPLES_PYTHON_DIR))


@pytest.mark.skipif(
    not _cuda_compute_importable(),
    reason="cuda.compute is not importable in this environment",
)
@pytest.mark.skipif(not _gpu_available(), reason="No NVIDIA GPU detected")
@pytest.mark.parametrize("sample", _SAMPLE_PATHS, ids=_sample_id)
def test_sample(sample: Path) -> None:
    """Run the sample as a subprocess and check its exit code."""
    env = os.environ.copy()
    # Do not let CI accidentally propagate a matplotlib backend / display.
    env.setdefault("MPLBACKEND", "Agg")

    result = subprocess.run(
        [sys.executable, str(sample)],
        cwd=sample.parent,
        env=env,
        check=False,
        capture_output=True,
        text=True,
        timeout=300,
    )

    # Always surface the sample's output to pytest so failures are diagnosable.
    if result.stdout:
        sys.stdout.write(result.stdout)
    if result.stderr:
        sys.stderr.write(result.stderr)

    if result.returncode == EXIT_WAIVED:
        pytest.skip(
            f"{_sample_id(sample)} exited with EXIT_WAIVED ({EXIT_WAIVED}); "
            "sample-declared skip"
        )
    assert result.returncode == 0, (
        f"Sample {_sample_id(sample)} exited with code {result.returncode}"
    )
