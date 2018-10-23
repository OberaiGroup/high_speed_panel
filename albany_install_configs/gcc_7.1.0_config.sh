
GCC_ROOT=
GCC_INSTALL=$GCC_ROOT/install
GCC_BUILD=$GCC_ROOT/build

./${GCC_ROOT}/configure \
  --prefix=$GCC_INSTALL \
  --disable-multilib    \
  --enable-languages=c,c++,fortan
