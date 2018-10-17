rm ~/user-config.jam
echo "using gcc : 7.1.0 : /usr/bin/g++ : <compileflags>"-O3 -march=native" <library-path>/usr/local/lib <find-shared-library>mpi ;" >> ~/user-config.jam
echo "using mpi : /usr/local/bin/mpicxx : <cxxflags>"-O3" <include>/usr/local/include <library-path>/usr/local/lib <find-shared-library>mpi ;" >> ~/user-config.jam

./bootstrap.sh --with-libraries=signals,regex,filesystem,system,mpi,serialization,thread,program_options,exception --prefix=/usr/local

