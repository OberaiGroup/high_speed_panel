export TRIDIR=/usr/local

cmake .. \
  -DCMAKE_C_COMPILER="mpicc" \
  -DCMAKE_CXX_COMPILER="mpicxx" \
  -DCMAKE_INSTALL_PREFIX=$TRIDIR \
  -DBUILD_SHARED_LIBS=ON \
  -DSCOREC_CXX_FLAGS="-g -O2 -Wall -Wextra" \
  -DENABLE_SIMMETRIX=OFF \
  -DENABLE_DSP=ON \
  -DENABLE_STK=ON \
  -DENABLE_STK_MESH=ON \
  -DENABLE_ZOLTAN=ON \
  -DTrilinos_PREFIX=$TRIDIR \
  -DZOLTAN_INCLUDE_DIR=$TRIDIR/include \
  -DZOLTAN_LIBRARY=$TRIDIR/lib/libzoltan.so \
  -DMETIS_LIBRARY=$TRIDIR/lib/libmetis.a    \
  -DPARMETIS_LIBRARY=$TRIDIR/lib/libparmetis.a \
  -DPARMETIS_INCLUDE_DIR=$TRIDIR/include \
  -DIS_TESTING=ON \
  -DMESHES=/home/pogo/scorec_test_meshes \
  -DBUILD_EXES=ON 
