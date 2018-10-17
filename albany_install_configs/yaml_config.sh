
GCC_MPI_DIR=/usr/local

cmake \
 -DCMAKE_CXX_COMPILER:STRING=${GCC_MPI_DIR}/bin/mpicxx \
 -DCMAKE_CXX_FLAGS:STRING='-march=native -O3 -DNDEBUG' \
 -DCMAKE_C_COMPILER:STRING=${GCC_MPI_DIR}/bin/mpicc \
 -DCMAKE_C_FLAGS:STRING='-march=native -O3 -DNDEBUG' \
 -DCMAKE_INSTALL_PREFIX:PATH=/usr/local \
 -DCMAKE_BUILD_TYPE:STRING=Release \
 -DBUILD_SHARED_LIBS:BOOL=ON \
 -DYAML_CPP_BUILD_TOOLS:BOOL=OFF \
..
