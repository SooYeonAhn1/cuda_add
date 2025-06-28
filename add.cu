// CUDA Vector Addition Example
// Based on:
// https://developer.nvidia.com/blog/even-easier-introduction-cuda/
// Modified for WSL2 + Unified Memory + Runtime Error Handling

#include <iostream>
#include <math.h>

#include <cuda_runtime.h>
#include <device_launch_parameters.h>

__global__
void add(int n, float *x, float *y) {
    int index = blockIdx.x * blockDim.x + threadIdx.x;
    int stride = blockDim.x * gridDim.x;
    for (int i = index; i < n; i += stride) {
        y[i] = x[i] + y[i];
    }
}

int main() {
    int N = 1 << 20;
    float *x, *y;
    cudaMallocManaged(&x, N*sizeof(float));
    cudaMallocManaged(&y, N*sizeof(float));

    for (int i = 0; i < N; ++i) {
        x[i] = 1.0f;
        y[i] = 2.0f;
    }

    int blockSize = 256;
    int numBlocks = (N + blockSize - 1) / blockSize;
    int device = 0;
    // cudaGetDeviceCount(&device);

    // if (device < 1) {
    //     std::cerr << "device ID: " << device << std::endl;
    // }

    device = 0;
    
    // cudaSetDevice(device);
    cudaGetDevice(&device);

    cudaMemPrefetchAsync(x, N*sizeof(float), device);
    cudaMemPrefetchAsync(y, N*sizeof(float), device);

    add<<<numBlocks, blockSize>>>(N, x, y);

    // cudaError_t err = cudaGetLastError();
    // if (err != cudaSuccess) {
    //     std::cerr << "CUDA kernel launch failed: " << cudaGetErrorString(err) << std::endl;
    // }

    cudaDeviceSynchronize();

    float maxError = 0.0f;
    for (int i = 0; i < N; ++i) {
        maxError = fmax(maxError, fabs(3.0f - y[i]));
    }
    
    std::cout << "max error is: " << maxError << std::endl;

    cudaFree(x);
    cudaFree(y);

    return 0;
}
