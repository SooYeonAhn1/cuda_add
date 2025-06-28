README.md
## Simple CUDA Vector Addition (Unified Memory + Prefetch)

This example demonstrates:
- CUDA kernel launch with grid-stride loop
- Unified memory allocation with `cudaMallocManaged`
- Prefetching for WSL2 using `cudaCpuDeviceId`
- Runtime error checking and device setup

## REFERENCE
This code is based on the NVIDIA blog post:  
[An Even Easier Introduction to CUDA](https://developer.nvidia.com/blog/even-easier-introduction-cuda/)  
by Mark Harris (NVIDIA Developer Blog)