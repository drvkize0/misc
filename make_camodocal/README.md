# build camodocal
build camodocal to an isolated directory for embedded system

## dependencies
install all dependencies to
~/install/include
~/install/lib

- camodocal
  - ceres-solver
    - suitesparse
      - openblas(lapack)
      - tbb
    - gflag
    - glog
    - tbb
  - opencv
    - openblas(lapack)
    - tbb
    - gflag
  - boost(filesystem, program_options)
