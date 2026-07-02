# simpleAWBarrier - Simple Arrive Wait Barrier

## Description

A simple demonstration of arrive wait barriers.

## Key Concepts

Arrive Wait Barrier, CCCL libcu++

## Supported SM Architectures

[SM 7.0 ](https://developer.nvidia.com/cuda-gpus)  [SM 7.2 ](https://developer.nvidia.com/cuda-gpus)  [SM 7.5 ](https://developer.nvidia.com/cuda-gpus)  [SM 8.0 ](https://developer.nvidia.com/cuda-gpus)  [SM 8.6 ](https://developer.nvidia.com/cuda-gpus)  [SM 8.7 ](https://developer.nvidia.com/cuda-gpus)  [SM 8.9 ](https://developer.nvidia.com/cuda-gpus)  [SM 9.0 ](https://developer.nvidia.com/cuda-gpus)

## Supported OSes

Linux, Windows, QNX

## Supported CPU Architecture

x86_64, armv7l, aarch64

## CUDA APIs involved

### [CCCL libcu++](https://nvidia.github.io/cccl/libcudacxx/)

`cuda::barrier` (`<cuda/barrier>`), `cuda::thread_scope_block`

### [CUDA Runtime API](http://docs.nvidia.com/cuda/cuda-runtime-api/index.html)
cudaStreamCreateWithFlags, cudaFree, cudaDeviceGetAttribute, cudaMallocHost, cudaFreeHost, cudaStreamSynchronize, cudaLaunchCooperativeKernel, cudaMalloc, cudaOccupancyMaxActiveBlocksPerMultiprocessor, cudaMemcpyAsync, cudaOccupancyMaxPotentialBlockSize

## Dependencies needed to build/run
CCCL (bundled with the CUDA Toolkit; see [`<cuda/barrier>`](https://nvidia.github.io/cccl/libcudacxx/standard_api/synchronization_library/barrier.html)), Multi-Block Cooperative Groups (MBCG).

## Prerequisites

Download and install the [CUDA Toolkit](https://developer.nvidia.com/cuda-downloads) for your corresponding platform.
Make sure the dependencies mentioned in [Dependencies]() section above are installed.

## References (for more details)
