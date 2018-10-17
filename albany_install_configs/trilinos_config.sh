#!/bin/bash -ex

# Modify these paths for your system.
TPLS=/usr/local
TRIDIR=/home/pogo/Trilinos
INSTALLDIR=$TPLS
MPI_DIR=/usr/local/bin
METISDIR=$TPLS
HDF5DIR=$TPLS
NETCDFDIR=$TPLS
BOOSTDIR=$TPLS
SuperLUDIR=$TPLS
MatioDIR=$TPLS
HAVE_LL=ON

cmake \
\
 -D Trilinos_DISABLE_ENABLED_FORWARD_DEP_PACKAGES=ON \
 -D CMAKE_INSTALL_PREFIX=${INSTALLDIR} \
 -D CMAKE_BUILD_TYPE=NONE \
 -D CMAKE_C_COMPILER=gcc-5 \
 -D CMAKE_CXX_COMPILER=mpicxx \
 -D CMAKE_C_FLAGS="-g -fPIC -O2" \
 -D CMAKE_CXX_FLAGS="-g -fPIC -O2 -Wno-deprecated-declarations -Wno-sign-compare -fno-omit-frame-pointer" \
 -D CMAKE_SKIP_RPATH=ON \
 -D CMAKE_INSTALL_RPATH_USE_LINK_PATH=OFF \
 -D TPL_ENABLE_MPI=ON \
 -D MPI_BASE_DIR=${MPIDIR} \
 -D CMAKE_VERBOSE_MAKEFILE=ON \
 -D BUILD_SHARED_LIBS=ON \
 -D Trilinos_EXTRA_LINK_FLAGS="-ldl -lgfortran" \
\
 -D Trilinos_ENABLE_SECONDARY_TESTED_CODE=ON \
 -D Trilinos_ENABLE_EXPORT_MAKEFILES=OFF \
 -D Trilinos_ASSERT_MISSING_PACKAGES=ON \
 -D Trilinos_ENABLE_ALL_PACKAGES=OFF \
 -D Trilinos_WARNINGS_AS_ERRORS_FLAGS="" \
 -D Trilinos_SET_INSTALL_RPATH=OFF \
\
 -D Trilinos_ENABLE_Shards=ON \
 -D Trilinos_ENABLE_Sacado=ON \
 -D Trilinos_ENABLE_Epetra=ON \
 -D Trilinos_ENABLE_EpetraExt=ON \
 -D Trilinos_ENABLE_Ifpack=ON \
 -D Trilinos_ENABLE_AztecOO=ON \
 -D Trilinos_ENABLE_Amesos=ON \
 -D Trilinos_ENABLE_Anasazi=ON \
 -D Trilinos_ENABLE_Belos=ON \
 -D Trilinos_ENABLE_ML=ON \
 -D Trilinos_ENABLE_NOX=ON \
 -D Trilinos_ENABLE_Stratimikos=ON \
 -D Trilinos_ENABLE_Thyra=ON \
 -D Trilinos_ENABLE_Rythmos=ON \
 -D Trilinos_ENABLE_Stokhos=ON \
 -D Trilinos_ENABLE_Piro=ON \
 -D Trilinos_ENABLE_Teko=ON \
 -D Trilinos_ENABLE_STKIO=ON \
 -D Trilinos_ENABLE_STKMesh=ON \
 -D Trilinos_ENABLE_SEACAS=ON \
 -D Trilinos_ENABLE_SEACASIoss=ON \
 -D Trilinos_ENABLE_SEACASExodus=ON \
 -D Trilinos_ENABLE_Tpetra=ON \
 -D Trilinos_ENABLE_Ifpack2=ON \
 -D Trilinos_ENABLE_Zoltan2=ON \
 -D Trilinos_ENABLE_MueLu=ON \
 -D Trilinos_ENABLE_MiniTensor=ON \
 -D Trilinos_ENABLE_SCOREC=ON \
 -D Trilinos_ENABLE_Teuchos=ON \
\
 -D Trilinos_ENABLE_Zoltan=ON \
 -D Zoltan_ENABLE_ULLONG_IDS=ON \
\
 -D Trilinos_ENABLE_Amesos2=ON \
 -D Amesos2_ENABLE_KLU2=ON \
\
 -D Trilinos_ENABLE_Kokkos=ON \
 -D Trilinos_ENABLE_KokkosCore=ON \
 -D Kokkos_ENABLE_Serial=ON \
 -D Kokkos_ENABLE_OpenMP=OFF \
 -D Kokkos_ENABLE_Pthread=OFF \
\
 -D Trilinos_ENABLE_Intrepid=ON \
 -D HAVE_INTREPID_KOKKOSCORE:BOOL=ON \
\
 -D Trilinos_ENABLE_Phalanx=ON \
 -D Phalanx_INDEX_SIZE_TYPE="INT" \
 -D Phalanx_SHOW_DEPRECATED_WARNINGS=OFF \
 -D Phalanx_KOKKOS_DEVICE_TYPE="SERIAL" \
\
 -D Trilinos_ENABLE_Intrepid2=ON \
 -D Intrepid2_ENABLE_KokkosDynRankView=ON \
\
 -D TPL_ENABLE_Boost=ON \
 -D Boost_INCLUDE_DIRS="${BOOSTDIR}/include" \
 -D Boost_LIBRARY_DIRS="${BOOSTDIR}/lib" \
 -D TPL_ENABLE_BoostLib=ON \
 -D BoostLib_INCLUDE_DIRS="${BOOSTDIR}/include" \
 -D BoostLib_LIBRARY_DIRS="${BOOSTDIR}/lib" \
\
 -D TPL_ENABLE_ParMETIS=ON \
 -D ParMETIS_INCLUDE_DIRS="${METISDIR}/include" \
 -D ParMETIS_LIBRARY_DIRS="${METISDIR}/lib" \
\
 -D TPL_ENABLE_Netcdf=ON \
 -D TPL_Netcdf_PARALLEL=ON \
 -D Netcdf_INCLUDE_DIRS="${NETCDFDIR}/include" \
 -D Netcdf_LIBRARY_DIRS="${NETCDFDIR}/lib" \
\
 -D TPL_ENABLE_METIS=ON \
 -D METIS_INCLUDE_DIRS="${METISDIR}/include" \
 -D METIS_LIBRARY_DIRS="${METISDIR}/lib" \
\
 -D TPL_ENABLE_HDF5=ON \
 -D HDF5_INCLUDE_DIRS="${HDF5DIR}/include" \
 -D HDF5_LIBRARY_DIRS="${HDF5DIR}/lib" \
\
 -D TPL_ENABLE_SuperLU=ON \
 -D SuperLU_INCLUDE_DIRS="${SuperLUDIR}/include" \
 -D SuperLU_LIBRARY_DIRS="${SuperLUDIR}/lib" \
\
 -D TPL_ENABLE_Matio=ON \
 -D Matio_INCLUDE_DIRS="${MatioDIR}/include" \
 -D Matio_LIBRARY_DIRS="${MatioDIR}/lib" \
\
 -D TPL_ENABLE_X11=OFF \
\
 -D Trilinos_ENABLE_EXPLICIT_INSTANTIATION=ON \
 -D Tpetra_INST_FLOAT=OFF \
 -D Tpetra_INST_INT_INT=ON \
 -D Tpetra_INST_DOUBLE=ON \
 -D Tpetra_INST_COMPLEX_FLOAT=OFF \
 -D Tpetra_INST_COMPLEX_DOUBLE=OFF \
 -D Tpetra_INST_INT_LONG=OFF \
 -D Tpetra_INST_INT_UNSIGNED=OFF \
 -D Tpetra_INST_INT_LONG_LONG=${HAVE_LL} \
\
 -D SEACASIoss_ENABLE_TESTS=ON\
\
  ${TRIDIR} \
2>&1 | tee config_log
