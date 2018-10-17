
./configure \
 CC=/usr/local/bin/mpicc   \
 CXX=/usr/local/bin/mpicxx \
 FC=/usr/local/bin/mpif90  \
 CXXFLAGS="-fPIC -O3 -march=native" \
 CFLAGS="-fPIC -O3 -march=native"   \
 FFLAGS="-fPIC -O3 -march=native"   \
 --prefix=/usr/local/ \
 --enable-parallel    \
 --enable-shared      \
 --with-zlib=/usr/local/
