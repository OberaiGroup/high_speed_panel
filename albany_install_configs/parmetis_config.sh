
export metis=/home/pogo/parmetis-4.0.3/metis
cmake \
 -DCMAKE_INSTALL_PREFIX=/usr/local \
 -DMETIS_PATH=$metis               \
 -DGKLIB_PATH=$metis/GKlib         \
 -DCMAKE_C_COMPILER=mpicc          \
 -DCMAKE_CXX_COMPILER=mpicxx       \
..
 
