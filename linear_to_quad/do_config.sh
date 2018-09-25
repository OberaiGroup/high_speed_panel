export BUILD_DIR=/home/jlclough/research/high_speed_panel/linear_to_quad/build
export SRC_DIR=/home/jlclough/research/high_speed_panel/linear_to_quad/src
export SCOREC=/usr/local/
export CXX=/usr/local/bin/mpicxx

cd $BUILD_DIR
cmake \
  -D SRC_DIR=${SRC_DIR} \
  -D SCOREC_INC=${SCOREC}/include \
  -D SCOREC_LIB=${SCOREC}/lib \
  -D CMAKE_CXX_FLAGS="-g -O3 -Wall -fPIC -lrt" \
  -D CMAKE_CXX_COMPILER=${CXX} \
  ../
