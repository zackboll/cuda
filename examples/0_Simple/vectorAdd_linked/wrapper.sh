#!/bin/sh -e

# PATH of the example to run. Should be e.g. examples/0_Simple/vectorAdd/
EXAMPLE_DIRECTORY="$PWD"
CUDA_BIN_DIR="/usr/local/cuda/bin/"
# Min compute capability. E.g. if you're on sm_75, SM_XX should be 75
SM_XX="75"

OBJ="$EXAMPLE_DIRECTORY/obj"
SRC="$EXAMPLE_DIRECTORY/src"

KERNEL_SRC_NAME="kernel_global.adb"
KERNEL_SRC_PATH="$SRC/$KERNEL_SRC_NAME"
KERNEL_PTX_NAME="${KERNEL_SRC_NAME%.*}.s"
KERNEL_PTX_PATH="$OBJ/$KERNEL_PTX_NAME"
KERNEL_OBJ_NAME="${KERNEL_SRC_NAME%.*}.o"
KERNEL_OBJ_PATH="$OBJ/$KERNEL_OBJ_NAME"
KERNEL_FATBIN_NAME="kernel_global.fatbin"
KERNEL_FATBIN_PATH="$OBJ/$KERNEL_FATBIN_NAME"
KERNEL_FATBIN_OBJ="$OBJ/$KERNEL_FATBIN_NAME.o"
KERNEL_FATBINASM_NAME="$KERNEL_FATBIN_NAME.s"
KERNEL_FATBINASM_PATH="$SRC/$KERNEL_FATBINASM_NAME"

mkdir -p "$OBJ"

"llvm-gcc" \
   -I"$EXAMPLE_DIRECTORY/../../../api/device_static/" \
   -O2 -S -gnatp -gnatn -mcpu=sm_"$SM_XX" --target=nvptx64 \
   "$KERNEL_SRC_PATH" -o "$KERNEL_PTX_PATH"

# Create GPU object file
"$CUDA_BIN_DIR/ptxas" -m64 -g --dont-merge-basicblocks --return-at-end -v --gpu-name sm_"$SM_XX" --output-file "$KERNEL_OBJ_PATH" "$KERNEL_PTX_PATH"

# Embed it all in a fat binary
"$CUDA_BIN_DIR/fatbinary" -64 --create "$KERNEL_FATBIN_PATH" -g --image=profile=sm_"$SM_XX",file="$KERNEL_OBJ_PATH" --image=profile=compute_"$SM_XX",file="$KERNEL_PTX_PATH"

# Create an object out of the fatbinary. Note: we need to move to the object
# directory to get ld to produce a predictable name.
CWD_BACKUP="$(pwd)"
cd "$(dirname "$KERNEL_FATBIN_PATH")"
ld -r -b binary "$KERNEL_FATBIN_NAME" -o "$KERNEL_FATBIN_OBJ"
cd "$CWD_BACKUP"

gprbuild -Pmain -largs "$KERNEL_FATBIN_OBJ"
