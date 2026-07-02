# globalToShmemAsyncCopy - Global Memory to Shared Memory Async Copy

## Description

This sample implements matrix multiplication using CCCL libcu++'s `cuda::pipeline` (`<cuda/pipeline>`) for asynchronous global->shared memory copies on compute capability 8.0 and higher, plus `cuda::barrier` (`<cuda/barrier>`) for arrive-wait synchronization between producer and consumer stages.

## Key Concepts

CUDA Runtime API, Linear Algebra, CPP11 CUDA, CCCL libcu++ (`cuda::pipeline`, `cuda::barrier`)

## Supported SM Architectures

[SM 7.0 ](https://developer.nvidia.com/cuda-gpus)  [SM 7.2 ](https://developer.nvidia.com/cuda-gpus)  [SM 7.5 ](https://developer.nvidia.com/cuda-gpus)  [SM 8.0 ](https://developer.nvidia.com/cuda-gpus)  [SM 8.6 ](https://developer.nvidia.com/cuda-gpus)  [SM 8.7 ](https://developer.nvidia.com/cuda-gpus)  [SM 8.9 ](https://developer.nvidia.com/cuda-gpus)  [SM 9.0 ](https://developer.nvidia.com/cuda-gpus)

## Supported OSes

Linux, Windows, QNX

## Supported CPU Architecture

x86_64, armv7l, aarch64

## CUDA APIs involved

### [CCCL libcu++](https://nvidia.github.io/cccl/libcudacxx/)

`cuda::pipeline` (`<cuda/pipeline>`), `cuda::barrier` (`<cuda/barrier>`), `cuda::make_pipeline`, `cuda::memcpy_async`, `cuda::pipeline_shared_state`, `cuda::pipeline_role::producer`, `cuda::pipeline_role::consumer`, `cuda::aligned_size_t`, `cuda::thread_scope_block`, `cuda::thread_scope_thread`

### [CUDA Runtime API](http://docs.nvidia.com/cuda/cuda-runtime-api/index.html)
cudaStreamCreateWithFlags, cudaMalloc, cudaDeviceGetAttribute, cudaFree, cudaMallocHost, cudaEventSynchronize, cudaEventRecord, cudaFreeHost, cudaStreamSynchronize, cudaEventDestroy, cudaEventElapsedTime, cudaMemsetAsync, cudaMemcpyAsync, cudaEventCreate

## Dependencies needed to build/run
CCCL (bundled with the CUDA Toolkit; see [`<cuda/pipeline>`](https://nvidia.github.io/cccl/libcudacxx/extended_api/synchronization_primitives/pipeline.html) and [`<cuda/barrier>`](https://nvidia.github.io/cccl/libcudacxx/standard_api/synchronization_library/barrier.html)).

## Prerequisites

Download and install the [CUDA Toolkit](https://developer.nvidia.com/cuda-downloads) for your corresponding platform.
Make sure the dependencies mentioned in [Dependencies]() section above are installed.

## References (for more details)
