# segmentationTreeThrust - CUDA Segmentation Tree Thrust Library

## Description

This sample builds an image segmentation tree using a parallel implementation of Boruvka's minimum-spanning-tree algorithm. The implementation is expressed almost entirely with CCCL Thrust: `thrust::sort`, `thrust::sort_by_key`, `thrust::inclusive_scan`, `thrust::inclusive_scan_by_key`, `thrust::adjacent_difference`, `thrust::for_each`, `thrust::copy_if`, `thrust::find_if`, `thrust::fill`, `thrust::sequence`, `thrust::device_malloc` / `device_free`, plus fancy iterators (`thrust::make_zip_iterator`, `make_counting_iterator`, `make_discard_iterator`). CCCL libcu++ `cuda::std::identity` and `cuda::std::tuple` are used inside functors.

## Key Concepts

CCCL Thrust, CCCL libcu++, Data-Parallel Algorithms, Performance Strategies

## Supported SM Architectures

[SM 5.0 ](https://developer.nvidia.com/cuda-gpus)  [SM 5.2 ](https://developer.nvidia.com/cuda-gpus)  [SM 5.3 ](https://developer.nvidia.com/cuda-gpus)  [SM 6.0 ](https://developer.nvidia.com/cuda-gpus)  [SM 6.1 ](https://developer.nvidia.com/cuda-gpus)  [SM 7.0 ](https://developer.nvidia.com/cuda-gpus)  [SM 7.2 ](https://developer.nvidia.com/cuda-gpus)  [SM 7.5 ](https://developer.nvidia.com/cuda-gpus)  [SM 8.0 ](https://developer.nvidia.com/cuda-gpus)  [SM 8.6 ](https://developer.nvidia.com/cuda-gpus)  [SM 8.7 ](https://developer.nvidia.com/cuda-gpus)  [SM 8.9 ](https://developer.nvidia.com/cuda-gpus)  [SM 9.0 ](https://developer.nvidia.com/cuda-gpus)

## Supported OSes

Linux, Windows

## Supported CPU Architecture

x86_64, armv7l

## CUDA APIs involved

### [CCCL Thrust](https://nvidia.github.io/cccl/thrust/)

`thrust::device_ptr`, `thrust::device_malloc` / `device_free` (`<thrust/device_malloc.h>` / `<thrust/device_free.h>`), `thrust::sort` and `thrust::sort_by_key` (`<thrust/sort.h>`), `thrust::inclusive_scan` and `thrust::inclusive_scan_by_key` (`<thrust/scan.h>`), `thrust::adjacent_difference` (`<thrust/adjacent_difference.h>`), `thrust::for_each` (`<thrust/for_each.h>`), `thrust::copy_if` (`<thrust/copy.h>`), `thrust::find_if` (`<thrust/find.h>`), `thrust::fill` (`<thrust/fill.h>`), `thrust::sequence` (`<thrust/sequence.h>`), `thrust::make_zip_iterator`, `thrust::make_counting_iterator`, `thrust::make_discard_iterator`, `thrust::greater_equal`, `thrust::not_equal_to`, `thrust::minimum`

### [CCCL libcu++](https://nvidia.github.io/cccl/libcudacxx/)

`cuda::std::identity` (`<cuda/std/functional>`), `cuda::std::tuple` (`<cuda/std/tuple>`)

### [CUDA Runtime API](http://docs.nvidia.com/cuda/cuda-runtime-api/index.html)
cudaMemcpy, cudaMemGetInfo, cudaEventSynchronize, cudaEventRecord, cudaMemset, cudaEventElapsedTime, cudaEventCreate

## Dependencies needed to build/run
CCCL Thrust and libcu++ (bundled with the CUDA Toolkit).

## Prerequisites

Download and install the [CUDA Toolkit](https://developer.nvidia.com/cuda-downloads) for your corresponding platform.

## References (for more details)
