# tbb
git clone -b 2019 --single-branch https://github.com/intel/tbb.git

# openblas
git clone -b v0.3.6 --single-branch https://github.com/xianyi/OpenBLAS.git
mv OpenBLAS openblas

# suitesparse
wget http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-5.4.0.tar.gz
tar zxvf ./SuiteSparse-5.4.0.tar.gz
mv SuiteSparse suitesparse

# gflag
git clone -b v2.2.2 --single-branch https://github.com/gflags/gflags.git

# glog
git clone -b v0.3.5 --single-branch https://github.com/google/glog.git

# ceres-solver
git clone -b 1.14.0 --single-branch https://github.com/ceres-solver/ceres-solver.git

# eigen
git clone -b 3.2.10 --single-branch https://github.com/eigenteam/eigen-git-mirror.git
mv eigen-git-mirror eigen

# opencv
git clone -b 3.4.6 --single-branch https://github.com/opencv/opencv.git
git clone -b 3.4.6 --single-branch https://github.com/opencv/opencv_contrib.git
cp ./download_opencv.sh ./opencv
cp ./download_opencv_contrib.sh ./opencv_contrib
./opencv/download_opencv.sh
./opencv_contrib/download_opencv_contrib.sh

# boost
git clone -b boost-1.69.0 --single-branch https://github.com/boostorg/boost.git
cd boost
git submodule update --init --recursive

# camodocal_porting
git clone ssh://lighthouse@192.168.1.110/~/dependencies/camodocal_porting.git

# camodocal_calib
git clone ssh://lighthouse@192.168.1.110/~/dependencies/camodocal_calib.git