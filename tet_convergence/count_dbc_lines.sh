#!/bin/bash

# Usage:
# <this script name> <jacobian.mm>

grep 1.00000000000000000e+00 $1 | # Search for exactly one
  sed -rn 's/([0-9]+) \1/&/p'   | # Make sure it is on the diagonal, Only print if it is
  wc -l                           # Count the number of lines
