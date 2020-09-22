package CUDA.Atomic_Functions is

   extern __device__ __device_builtin__ int          __iAtomicAdd(int *address, int val);
extern __device__ __device_builtin__ unsigned int __uAtomicAdd(unsigned int *address, unsigned int val);
extern __device__ __device_builtin__ int          __iAtomicExch(int *address, int val);
extern __device__ __device_builtin__ unsigned int __uAtomicExch(unsigned int *address, unsigned int val);
extern __device__ __device_builtin__ float        __fAtomicExch(float *address, float val);
extern __device__ __device_builtin__ int          __iAtomicMin(int *address, int val);
extern __device__ __device_builtin__ unsigned int __uAtomicMin(unsigned int *address, unsigned int val);
extern __device__ __device_builtin__ int          __iAtomicMax(int *address, int val);
extern __device__ __device_builtin__ unsigned int __uAtomicMax(unsigned int *address, unsigned int val);
extern __device__ __device_builtin__ unsigned int __uAtomicInc(unsigned int *address, unsigned int val);
extern __device__ __device_builtin__ unsigned int __uAtomicDec(unsigned int *address, unsigned int val);
extern __device__ __device_builtin__ int          __iAtomicAnd(int *address, int val);
extern __device__ __device_builtin__ unsigned int __uAtomicAnd(unsigned int *address, unsigned int val);
extern __device__ __device_builtin__ int          __iAtomicOr(int *address, int val);
extern __device__ __device_builtin__ unsigned int __uAtomicOr(unsigned int *address, unsigned int val);
extern __device__ __device_builtin__ int          __iAtomicXor(int *address, int val);
extern __device__ __device_builtin__ unsigned int __uAtomicXor(unsigned int *address, unsigned int val);
extern __device__ __device_builtin__ int          __iAtomicCAS(int *address, int compare, int val);
extern __device__ __device_builtin__ unsigned int __uAtomicCAS(unsigned int *address, unsigned int compare, unsigned int val);

end CUDA.Atomic_Functions;
