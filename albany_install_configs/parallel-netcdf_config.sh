 CC=/usr/local/bin/mpicc   \
 FC=/usr/local/bin/mpif90  \
 CXX=/usr/local/bin/mpicxx \
 CXXFLAGS="-O3 -march=native -fPIC" \
 CFLAGS="-O3 -march=native -fPIC"   \
 FFLAGS="-O3 -march=native -fPIC"   \
 F77FLAGS="-O3 -march=native -fPIC"  \
 F90FLAGS="-O3 -march=native -fPIC"  \
 FCLAGS="-O3 -march=native -fPIC"   \
./configure 
