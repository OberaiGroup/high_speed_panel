############################################################################
#
#  Program:         SuperLU
#
#  Module:          make.inc
#
#  Purpose:         Top-level Definitions
#
#  Creation date:   October 2, 1995
#
#  Modified:	    February 4, 1997  Version 1.0
#		    November 15, 1997 Version 1.1
#		    September 1, 1999 Version 2.0
#
############################################################################
#
#  The machine (platform) identifier to append to the library names
#
PLAT = _linux

#
#  The name of the libraries to be created/linked to
#
SuperLUroot	  = /home/pogo/SuperLU_4.3
SUPERLULIB   	= $(SuperLUroot)/lib/libsuperlu_4.3.a
TMGLIB       	= libtmglib.a

## BLASLIB   	= /usr/local/lib/libblas.a

BLASDEF 	= -DUSE_VENDOR_BLAS
BLASLIB   	= /usr/local/lib/libblas.a

## ATLAS BLAS causes single-precision to fail
#BLASLIB   	= -L/usr/lib/atlas -lblas
## This BLAS causes single-precision to fail the test in SuperLU
#BLASLIB 	= -L/usr/lib -lblas

LIBS		= $(SUPERLULIB) $(BLASLIB)

#
#  The archiver and the flag(s) to use when building archive (library)
#  If your system has no ranlib, set RANLIB = echo.
#
ARCH         = ar
ARCHFLAGS    = cr
RANLIB       = ranlib

CC           = /usr/local/bin/mpicc -fPIC -O3 -march=native
CFLAGS 	     = -O3 -DNDEBUG -DPRNTlevel=0 -DAdd_  
NOOPTS       = 
FORTRAN	     = /usr/local/bin/mpifort
FFLAGS       = -O3 -fPIC -march=native
LOADER       = $(CC)
LOADOPTS     =

#
#  C preprocessor defs for compilation for the Fortran interface
#  (-DNoChange, -DAdd_, -DAdd__, or -DUpCase)
#
CDEFS        = -DAdd_
#
# The directory in which Matlab is installed
#
# MATLAB	     = /usr/sww/matlab

