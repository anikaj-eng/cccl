# lineOfSight - Line of Sight

## Description

This sample is an implementation of a simple line-of-sight algorithm: Given a height map and a ray originating at some observation point, it computes all the points along the ray that are visible from the observation point. The implementation is built on CCCL Thrust: sample points are stored in `thrust::device_vector`, angles to the observation point are computed with a Thrust unary transform, and a `thrust::inclusive_scan` with `thrust::maximum` produces the running-maximum angle used to classify visible points.

## Key Concepts

CCCL Thrust, Parallel Scan, Inclusive Prefix Max

## Supported SM Architectures

[SM 5.0 ](https://developer.nvidia.com/cuda-gpus)  [SM 5.2 ](https://developer.nvidia.com/cuda-gpus)  [SM 5.3 ](https://developer.nvidia.com/cuda-gpus)  [SM 6.0 ](https://developer.nvidia.com/cuda-gpus)  [SM 6.1 ](https://developer.nvidia.com/cuda-gpus)  [SM 7.0 ](https://developer.nvidia.com/cuda-gpus)  [SM 7.2 ](https://developer.nvidia.com/cuda-gpus)  [SM 7.5 ](https://developer.nvidia.com/cuda-gpus)  [SM 8.0 ](https://developer.nvidia.com/cuda-gpus)  [SM 8.6 ](https://developer.nvidia.com/cuda-gpus)  [SM 8.7 ](https://developer.nvidia.com/cuda-gpus)  [SM 8.9 ](https://developer.nvidia.com/cuda-gpus)  [SM 9.0 ](https://developer.nvidia.com/cuda-gpus)

## Supported OSes

Linux, Windows

## Supported CPU Architecture

x86_64, armv7l

## CUDA APIs involved

### [CCCL Thrust](https://nvidia.github.io/cccl/thrust/)

`thrust::device_vector` (`<thrust/device_vector.h>`), `thrust::host_vector` (`<thrust/host_vector.h>`), `thrust::inclusive_scan` (`<thrust/scan.h>`), `thrust::copy` (`<thrust/copy.h>`), `thrust::maximum`, `thrust::raw_pointer_cast`

### [CUDA Runtime API](http://docs.nvidia.com/cuda/cuda-runtime-api/index.html)
cudaCreateChannelDesc, cudaMallocArray, cudaFreeArray, cudaDeviceSynchronize, cudaCreateTextureObject

## Dependencies needed to build/run
CCCL Thrust (bundled with the CUDA Toolkit).

## Prerequisites

Download and install the [CUDA Toolkit](https://developer.nvidia.com/cuda-downloads) for your corresponding platform.

## References (for more details)
