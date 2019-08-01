# required third-party tools
sudo apt-get install cmake
sudo apt-get install m4
sudo apt-get install automake
sudo apt-get install libtool
sudo apt-get install wget
sudo apt-get install curl
sudo apt-get install gfortran-7

# set environment variable
# needed by suitesparse and opencv
export LD_LIBRARY_PATH=~/install/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}

# build tbb
cd tbb
make tbb_build_prefix=install
cp ./build/install_release *.so* ~/install/lib
cp -r ./include/tbb ~/install/include
cd ..

# openblas
cd openblas
make CC=/usr/bin/gcc FC=/usr/bin/gfortran-7
make install PREFIX=~/install OPENBLAS_INCLUDE_DIR=~/install/include/openblas
cd ..

# lapack
cd lapack
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=~/install -DCMAKE_INSTALL_INCLUDEDIR=~/install/include/openblas -DCMAKE_Fortran_COMPILER=/usr/bin/gfortran-7 -DLAPACKE=ON
make
make install PREFIX=~/install
cd ..

# suitesparse
cd suitesparse
make metisinstall BLAS=~/install/lib/libopenblas.so LAPACK=~/install/lib/liblapack.so TBB=~/install/lib/libtbb.so.2 INSTALL=~/install INSTALL_INCLUDE=~/install/include/suitesparse INSTALL_LIB=~/install/lib
make -j16 BLAS=~/install/lib/libopenblas.so LAPACK=~/install/lib/liblapack.so TBB=~/install/lib/libtbb.so.2 INSTALL=~/install INSTALL_INCLUDE=~/install/include/suitesparse INSTALL_LIB=~/install/
lib
make install BLAS=~/install/lib/libopenblas.so LAPACK=~/install/lib/liblapack.so TBB=~/install/lib/libtbb.so.2 INSTALL=~/install INSTALL_INCLUDE=~/install/include/suitesparse INSTALL_LIB=~/install/lib
cd ..

# eigen
cd eigen
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=~/install -DCMAKE_Fortran_COMPILER=/usr/bin/gfortran-7 -DCHOLMOD_LIBRARIES=~/install/lib/libcholmod.so -DMETIS_INCLUDES=~/install/include/suitesparse -DMETIS_LIBRARIES=~/install/lib/libmetis.so -DSPQR_INCLUDES=~/install/suitesparse/spqr.h -DSPQR_LIBRARIES=~/install/lib/libspqr.so
make install
cd ..

# gflags
cd gflags
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=~/install -DBUILD_SHARED_LIBS=ON
make install
cd ..

# glog
cd glog
autoreconf --force --install
./configure --prefix=/home/drvkize/install
make
make install
cd ..

# ceres-solver
cd ceres-solver
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=~/install -DEIGEN_INCLUDE_DIR_HINTS=~/install/include/eigen3 -DSUITESPARSE_INCLUDE_DIR_HINTS=~/install/include/suitesparse -DSUITESPARSE_LIBRARY_DIR_HINTS=~/install/lib -DTBB_INCLUDE_DIR=~/install/include/tbb -DTBB_LIBRARY=~/install/lib -DGFLAGS_INCLUDE_DIR_HINTS=~/install/include/gflags -DGFLAGS_LIBRARY_DIR_HINTS=~/install/lib -DGLOG_INCLUDE_DIR_HINTS=~/install/include/glog -DGLOG_LIBRARY_DIR_HINTS=~/install/lib
make
make install
cd ..

# opencv
cd opencv
../opencv_contrib/download.sh
./download.sh
mkdir build
./build.sh
cd ..
