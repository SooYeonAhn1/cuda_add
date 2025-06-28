#include <iostream>
#include <math.h>

void add(int n, float * x, float * y) {
    for (int i = 0; i < n; ++i) {
        y[i] += x[i];
    }
}

int main() {
    int N = 1 << 20;
    float * x = new float[N];
    float * y = new float[N];

    for (int i = 0; i < N; ++i) {
        x[i] = 1.0f;
        y[i] = 2.0f;
    }

    add(N, x, y);

    float maxError = 0.0f;
    for (int i = 0; i < N; ++i) {
        maxError = fmax(maxError, fabs(3.0f - y[i]));
    }
    
    std::cout << "max error is: " << maxError << std::endl;

    delete[] x;
    delete[] y;

    return 0;
}
