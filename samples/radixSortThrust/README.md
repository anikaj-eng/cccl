# radixSortThrust - CUDA Radix Sort (Thrust Library)

## Description

This sample demonstrates a very fast and efficient parallel radix sort using CCCL Thrust. The included RadixSort wrapper drives `thrust::sort` and `thrust::sort_by_key` on `thrust::device_vector<unsigned int|float>` and can sort either key-value pairs or keys only. Input data is generated on the host with `thrust::default_random_engine` and `thrust::uniform_int_distribution` / `thrust::uniform_real_distribution`.

## Key Concepts

CCCL Thrust, Data-Parallel Algorithms, Performance Strategies

## Supported SM Architectures

[SM 5.0 ](https://developer.nvidia.com/cuda-gpus)  [SM 5.2 ](https://developer.nvidia.com/cuda-gpus)  [SM 5.3 ](https://developer.nvidia.com/cuda-gpus)  [SM 6.0 ](https://developer.nvidia.com/cuda-gpus)  [SM 6.1 ](https://developer.nvidia.com/cuda-gpus)  [SM 7.0 ](https://developer.nvidia.com/cuda-gpus)  [SM 7.2 ](https://developer.nvidia.com/cuda-gpus)  [SM 7.5 ](https://developer.nvidia.com/cuda-gpus)  [SM 8.0 ](https://developer.nvidia.com/cuda-gpus)  [SM 8.6 ](https://developer.nvidia.com/cuda-gpus)  [SM 8.7 ](https://developer.nvidia.com/cuda-gpus)  [SM 8.9 ](https://developer.nvidia.com/cuda-gpus)  [SM 9.0 ](https://developer.nvidia.com/cuda-gpus)

## Supported OSes

Linux, Windows

## Supported CPU Architecture

x86_64, armv7l

## CUDA APIs involved

### [CCCL Thrust](https://nvidia.github.io/cccl/thrust/)

`thrust::device_vector` (`<thrust/device_vector.h>`), `thrust::host_vector` (`<thrust/host_vector.h>`), `thrust::sort` and `thrust::sort_by_key` (`<thrust/sort.h>`), `thrust::sequence` (`<thrust/sequence.h>`), `thrust::copy` (`<thrust/copy.h>`), `thrust::is_sorted`, `thrust::default_random_engine`, `thrust::uniform_int_distribution`, `thrust::uniform_real_distribution` (`<thrust/random.h>`)

### [CUDA Runtime API](http://docs.nvidia.com/cuda/cuda-runtime-api/index.html)
cudaEventSynchronize, cudaEventRecord, cudaGetDevice, cudaEventDestroy, cudaEventElapsedTime, cudaGetDeviceProperties, cudaEventCreate

## Dependencies needed to build/run
CCCL Thrust (bundled with the CUDA Toolkit).

## Prerequisites

Download and install the [CUDA Toolkit](https://developer.nvidia.com/cuda-downloads) for your corresponding platform.

## References (for more details)

[whitepaper](./doc/readme.txt)
