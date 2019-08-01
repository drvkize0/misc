#!/bin/bash

cur_dir=$(pwd)

if [ ! -d build ]
then
mkdir build
fi

export OpenBLAS_HOME=~/install/include/openblas
export OpenBLAS=~/install

cd build
cmake .. \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=~/install \
	-DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
	-DWITH_CUDA=OFF \
	-DWITH_TBB=ON \
	-DTBB_ENV_INCLUDE=~/install/include/ \
	-DTBB_ENV_LIB=~/install/lib/libtbb.so.2 \
	-DWITH_EIGEN=ON \
	-DEIGEN_INCLUDE_PATH=~/install/include/eigen3 \
	-DWITH_LAPACK=ON \
	-DLAPACK_INCLUDE_DIR=~/install/include/openblas \
	-DOPENCV_ENABLE_NONFREE:BOOL=ON \
    -DBUILD_PERF_TESTS=OFF \
    -DBUILD_TESTS=OFF \
	-DINSTALL_PYTHON_EXAMPLES=OFF \
	-DBUILD_EXAMPLES=OFF \
	-DOPENCV_GENERATE_PKGCONFIG=YES \
	-DOPENCV_IPPICV_URL=file://$cur_dir/downloads/ippicv/ \
	-DOPENCV_BOOSTDESC_URL=file://$cur_dir/../opencv_contrib/downloads/boostdesc/ \
    -DOPENCV_VGGDESC_URL=file://$cur_dir/../opencv_contrib/downloads/vgg/ \
    -DOPENCV_FACE_ALIGNMENT_URL=file://$cur_dir/../opencv_contrib/downloads/face/
cd ..
