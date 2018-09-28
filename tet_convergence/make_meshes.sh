#!/bin/bash

CONVERGENCE_DIR=/home/jlclough/research/high_speed_panel/tet_convergence
TESTING_DIR=$CONVERGENCE_DIR/testing
LINEAR_DIR=$TESTING_DIR/linear
QUADRATIC_DIR=$TESTING_DIR/quadratic
LIN2QUAD_EXEC=/home/jlclough/research/high_speed_panel/linear_to_quad/build/src/linear_to_quad

NUM_MESHES=2
NUM_PROCS=4

# First make basic linear meshes for composite tets
cd $LINEAR_DIR

VALUE=1
V10=10
for (( i=0; i<$NUM_MESHES; i++))
do
  mpirun -n $NUM_PROCS \
    box \
    10 $V10 $VALUE \
    1  1    0.01 \
    1 model_${VALUE}_.dmg mesh_${VALUE}_.smb 
  (( VALUE*=2 ))
  (( V10=VALUE*10 ))
done

# Move to quadratic Directory, copy linear meshes
cd $QUADRATIC_DIR
cp $LINEAR_DIR/*  $QUADRATIC_DIR

# Convert meshes to use quadratic shape functions
VALUE=1
for (( i=0; i<$NUM_MESHES; i++))
do
  mpirun -n $NUM_PROCS \
    ${LIN2QUAD_EXEC} \
    model_${VALUE}_.dmg mesh_${VALUE}_.smb
  (( VALUE*=2 ))
done
