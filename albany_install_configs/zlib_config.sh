
cmake \
 -DCMAKE_C_COMPILER=/usr/local/bin/mpicc \
 -DCMAKE_C_FLAGS='-O3 -m64 -march=x86-64' \
 -DCMAKE_INSTALL_PREFIX=/usr/local/ \
..
