export BUILD_DIR=/home/jlclough/research/high_speed_panel/increase_smb_order/build
export SRC_DIR=/home/jlclough/research/high_speed_panel/increase_smb_order/src
export SCOREC_INC=/usr/local/include

cd $BUILD_DIRA
cmake \
  -D SRC_DIR=${SRC_DIR} \
  -D SCOREC_INC=${SCOREC_INC} \
  -D CMAKE_CXX_FLAGS="-g -O3 -Wall -fPIC -lrt" \
  ../
