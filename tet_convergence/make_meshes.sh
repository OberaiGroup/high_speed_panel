#!/bin/bash

export CONVERGENCE_DIR=/home/jlclough/research/high_speed_panel/tet_convergence
export TESTING_DIR=$CONVERGENCE_DIR/testing
export LINEAR_DIR=$TESTING_DIR/linear
export QUADRATIC_DIR=$TESTING_DIR/quadratic
export LIN2QUAD_EXEC=/home/jlclough/research/high_speed_panel/linear_to_quad/build/src/linear_to_quad

# First make basic linear meshes for composite tets
cd $LINEAR_DIR

VALUE=1
V10=0
for i in {0..2}
do
  mpirun -n 4 box \
    10 $V10 $VALUE \
    1  1    0.01 \
    1 model_$VALUE_.dmg mesh_$VALUE_.smb 
  (( VALUE*=2 ))
  (( V10=VALUE*10 ))
done

# Move to quadratic Direcotry, copy linear meshes
cd $QUADRATIC_DIR
cp $LINEAR_DIR/*  $QUADRATIC_DIR

# Convert meshes to use quadratic shape functions
${LIN2QUAD_EXEC} model_1.dmg mesh_1_.smb
${LIN2QUAD_EXEC} model_2.dmg mesh_2_.smb
${LIN2QUAD_EXEC} model_4.dmg mesh_4_.smb
${LIN2QUAD_EXEC} model_8.dmg mesh_8_.smb
${LIN2QUAD_EXEC} model_16.dmg mesh_16_.smb
