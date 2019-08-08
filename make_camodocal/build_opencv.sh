#!/bin/bash

# parse commandline options
while getopts p: option
do
case "${option}"
in
p) prefix=${OPTARG};;
esac
done

include_prefix=${prefix}/include
lib_prefix=${prefix}/lib

cur_dir=$(pwd)

if [ ! -d build ]
then
mkdir build
fi

export OpenBLAS_HOME=${include_prefix}/openblas
export OpenBLAS=${prefix}

cd build
cmake .. \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=${prefix} \
	-DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
	-DWITH_CUDA=OFF \
	-DWITH_TBB=ON \
	-DTBB_ENV_INCLUDE=${include_prefix}/ \
	-DTBB_ENV_LIB=${lib_prefix}/libtbb.so.2 \
	-DWITH_EIGEN=ON \
	-DEIGEN_INCLUDE_PATH=${include_prefix}/eigen3 \
	-DWITH_LAPACK=ON \
	-DLAPACK_INCLUDE_DIR=${include_prefix}/openblas \
	-DOPENCV_ENABLE_NONFREE=ON \
	-WITH_GTK=ON \
    -DBUILD_PERF_TESTS=OFF \
    -DBUILD_TESTS=OFF \
	-DINSTALL_PYTHON_EXAMPLES=OFF \
	-DBUILD_EXAMPLES=OFF \
	-DOPENCV_IPPICV_URL=file://$cur_dir/downloads/ippicv/ \
	-DOPENCV_BOOSTDESC_URL=file://$cur_dir/../opencv_contrib/downloads/boostdesc/ \
    -DOPENCV_VGGDESC_URL=file://$cur_dir/../opencv_contrib/downloads/vgg/ \
    -DOPENCV_FACE_ALIGNMENT_URL=file://$cur_dir/../opencv_contrib/downloads/face/
make
make install
cd ..
