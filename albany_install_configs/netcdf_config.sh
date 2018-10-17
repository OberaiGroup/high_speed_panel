LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib \
CC=/usr/local/bin/mpicc   \
CXX=/usr/local/bin/mpicxx \
FC=/usr/local/bin/mpif90  \
CXXFLAGS="-I/usr/local/include -O3 -march=native -fPIC " \
CPPFLAGS="-I/usr/local/include -O3 -march=native -fPIC " \
CFLAGS="-I/usr/local/include -O3 -march=native -fPIC"   \
LDFLAGS="-L/usr/local/lib -O3 -march=native -fPIC"      \
./configure           \
 --prefix=/usr/local/ \
 --disable-fsync \
 --enable-shared \
 --disable-doxygen \
 --enable-netcdf-4 \
 --enable-pnetcdf
