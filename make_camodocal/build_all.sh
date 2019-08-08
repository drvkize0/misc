#!/bin/bash

# parse commandline options
prefix="/home/drvkize/env/env_camodocal"
debug=0
while getopts "p:d" options
do
case "${options}"
in
p)
    prefix=${OPTARG}
    ;;
d)
    debug=1
    ;;
esac
done

include_prefix="${prefix}/include"
lib_prefix="${prefix}/lib"

echo "include_prefix=${include_prefix}"
echo "lib_prefix=${lib_prefix}"
echo "prefix=${prefix}"
echo "debug=${debug}"

if [ ${debug} -eq 0 ]
then
   export __PASS="1"
else
   export __PASS="0"
fi

function pause(){
   if [ ${__PASS} -eq 0 ]
   then
      read -p "$*"
   fi
}

function yesno(){
   if [ ${__PASS} -eq 0 ]
   then
      read -es -p "$*" -n 1 key
      if [ "${key}" == "y" ]
      then
         return 1
      else
         return 0
      fi
   else
      return 1
   fi
}

if [ ! -d ${include_prefix} ]
   then
   mkdir ${include_prefix}
fi

if [ ! -d ${lib_prefix} ]
   then
   mkdir ${lib_prefix}
fi

# set environment variables
export LD_LIBRARY_PATH=${lib_prefix}
echo LD_LIBRARY_PATH=$LD_LIBRARY_PATH

# tbb
yesno 'install tbb y/n: '
if [ $? -eq 1 ]
then
cd tbb
make tbb_build_prefix=install
cp ./build/install_release/*.so* ${lib_prefix}
cp -r ./include/tbb ${include_prefix}
cd ..
pause 'tbb installed...'
fi

# openblas
yesno 'install openblas y/n: '
if [ $? -eq 1 ]
then
cd openblas
make CC=/usr/bin/gcc FC=/usr/bin/gfortran-7
make install PREFIX=${prefix} OPENBLAS_INCLUDE_DIR=${include_prefix}/openblas
cd ..
pause 'openblas installed...'
fi

# lapack
yesno 'install lapack y/n: '
if [ $? -eq 1 ]
then
cd openblas
cd lapack-netlib
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${prefix} -DCMAKE_INSTALL_INCLUDEDIR=${include_prefix}/openblas -DCMAKE_Fortran_COMPILER=/usr/bin/gfortran-7 -DBUILD_SHARED_LIBS=ON -DLAPACKE=ON
make
make install PREFIX=${prefix}
cd ..
cd ..
cd ..
pause 'lapack installed...'
fi

# suitesparse
yesno 'install suitesparse y/n: '
if [ $? -eq 1 ]
then
cd suitesparse
make metisinstall BLAS=${lib_prefix}/libopenblas.so LAPACK=${lib_prefix}/liblapack.so TBB=${lib_prefix}/libtbb.so.2 INSTALL=${prefix} INSTALL_INCLUDE=${include_prefix}/suitesparse INSTALL_LIB=${lib_prefix}
make
#BLAS=${lib_prefix}/libopenblas.so LAPACK=${lib_prefix}/liblapack.a TBB=${lib_prefix}/libtbb.so.2 INSTALL=${prefix} INSTALL_INCLUDE=${include_prefix}/suitesparse INSTALL_LIB=${lib_prefix}
make install BLAS=${lib_prefix}/libopenblas.so LAPACK=${lib_prefix}/liblapack.so TBB=${lib_prefix}/libtbb.so.2 INSTALL=${prefix} INSTALL_INCLUDE=${include_prefix}/suitesparse INSTALL_LIB=${lib_prefix}
cd ..
pause 'suitesparse installed...'
fi

# gflag
yesno 'install gflag y/n: '
if [ $? -eq 1 ]
then
cd gflags
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${prefix} -DBUILD_SHARED_LIBS=ON
make install
cd ..
cd ..
pause 'gflag installed...'
fi

# glog
yesno 'install glog y/n: '
if [ $? -eq 1 ]
then
cd glog
autoreconf --force --install
./configure --prefix=${prefix}
make
make install
cd ..
pause 'glog installed...'
fi

# eigen
yesno 'install eigen y/n: '
if [ $? -eq 1 ]
then
cd eigen
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${prefix} -DCMAKE_Fortran_COMPILER=/usr/bin/gfortran-7 -DCHOLMOD_LIBRARIES=${lib_prefix}/libcholmod.so -DMETIS_INCLUDES=${include_prefix}/suitesparse -DMETIS_LIBRARIES=${lib_prefix}/libmetis.so -DSPQR_INCLUDES=${include_prefix}/suitesparse/spqr.h -DSPQR_LIBRARIES=${lib_prefix}/libspqr.so
make install
cd ..
cd ..
pause 'eigen installed...'
fi

# ceres-solver
yesno 'install ceres-solver y/n: '
if [ $? -eq 1 ]
then
cd ceres-solver
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${prefix} -DEIGEN_INCLUDE_DIR_HINTS=${include_prefix}/eigen3 -DSUITESPARSE_INCLUDE_DIR_HINTS=${include_prefix}/suitesparse -DSUITESPARSE_LIBRARY_DIR_HINTS=${lib_prefix} -DTBB_INCLUDE_DIR=${include_prefix}/tbb -DTBB_LIBRARY=${lib_prefix} -DGFLAGS_INCLUDE_DIR_HINTS=${include_prefix}/gflags -DGFLAGS_LIBRARY_DIR_HINTS=${lib_prefix} -DGLOG_INCLUDE_DIR_HINTS=${include_prefix}/glog -DGLOG_LIBRARY_DIR_HINTS=${lib_prefix}
make
make install
cd ..
cd ..
pause 'ceres-solver installed...'
fi

# opencv
yesno 'install opencv y/n: '
if [ $? -eq 1 ]
then
cp ./build_opencv.sh ./opencv
cd opencv
./build_opencv.sh -p ${prefix}
cd ..
pause 'opencv installed...'
fi

# boost
yesno 'install boost y/n: '
if [ $? -eq 1 ]
then
cd boost
./bootstrap.sh
./b2 --prefix=/home/drvkize/env/env_camodocal --with-system --with-filesystem --with-program_options --with-serialization --with-thread link=shared
./b2 install --prefix=/home/drvkize/env/env_camodocal --with-system --with-filesystem --with-program_options --with-serialization --with-thread link=shared
cd ..
fi

# camodocal_porting
yesno 'install camodocal_porting y/n: '
if [ $? -eq 1 ]
then
cd camodocal_porting
./build.sh -p ${prefix}
cd ..
fi

# camodocal_calib
yesno 'install camodocal_calib y/n: '
if [ $? -eq 1 ]
then
cd camodocal_calib
./build.sh -p ${prefix}
cd ..
fi
