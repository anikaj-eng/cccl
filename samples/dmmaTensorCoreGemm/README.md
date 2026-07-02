# dmmaTensorCoreGemm - Double Precision Tensor Core GEMM

## Description

CUDA sample demonstrating double-precision GEMM using the Double-precision Warp Matrix Multiply and Accumulate (WMMA) API introduced with CUDA 11 on Ampere-family tensor cores. The sample uses CCCL libcu++'s `cuda::pipeline` (`<cuda/pipeline>`) and `cuda::barrier` (`<cuda/barrier>`) for asynchronous gmem->shmem loads to overlap memory transfers with tensor-core compute and to reduce register pressure. It also demonstrates the cooperative groups async-copy interface over a group.

## Key Concepts

Matrix Multiply, WMMA, Tensor Cores, CCCL libcu++ (`cuda::pipeline`, `cuda::barrier`)

## Supported SM Architectures

[SM 8.0 ](https://developer.nvidia.com/cuda-gpus)  [SM 8.6 ](https://developer.nvidia.com/cuda-gpus)  [SM 8.7 ](https://developer.nvidia.com/cuda-gpus)  [SM 8.9 ](https://developer.nvidia.com/cuda-gpus)  [SM 9.0 ](https://developer.nvidia.com/cuda-gpus)

## Supported OSes

Linux, Windows

## Supported CPU Architecture

x86_64, aarch64

## CUDA APIs involved

### [CCCL libcu++](https://nvidia.github.io/cccl/libcudacxx/)

`cuda::pipeline` (`<cuda/pipeline>`), `cuda::barrier` (`<cuda/barrier>`), `cuda::make_pipeline`, `cuda::memcpy_async`, `cuda::pipeline_consumer_wait_prior`, `cuda::aligned_size_t`, `cuda::thread_scope_thread`, `cuda::std::type_traits`

### [CUDA Runtime API](http://docs.nvidia.com/cuda/cuda-runtime-api/index.html)
cudaMemcpy, cudaFree, cudaGetErrorString, cudaGetLastError, cudaEventSynchronize, cudaFuncSetAttribute, cudaEventRecord, cudaMemset, cudaMalloc, cudaEventElapsedTime, cudaGetDeviceProperties, cudaEventCreate

## Dependencies needed to build/run
CCCL (bundled with the CUDA Toolkit; see [`<cuda/pipeline>`](https://nvidia.github.io/cccl/libcudacxx/extended_api/synchronization_primitives/pipeline.html) and [`<cuda/barrier>`](https://nvidia.github.io/cccl/libcudacxx/standard_api/synchronization_library/barrier.html)).

## Prerequisites

Download and install the [CUDA Toolkit](https://developer.nvidia.com/cuda-downloads) for your corresponding platform.
Make sure the dependencies mentioned in [Dependencies]() section above are installed.

## References (for more details)
