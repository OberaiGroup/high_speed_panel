#!/bin/bash

CONVERGENCE_DIR=/home/jlclough/research/high_speed_panel/tet_convergence
TESTING_DIR=$CONVERGENCE_DIR/testing
LINEAR_DIR=$TESTING_DIR/linear
QUADRATIC_DIR=$TESTING_DIR/quadratic
LIN2QUAD_EXEC=/home/jlclough/research/high_speed_panel/linear_to_quad/build/src/linear_to_quad

export NUM_MESHES=10
export NUM_PROCS=4

# First make basic linear meshes for composite tets
cd $LINEAR_DIR

VALUE=4
GEOM_AR=100
AR=1
VAR=1
for (( i=0; i<$NUM_MESHES; i++))
do
  (( VAR=VALUE*GEOM_AR/AR))
  # Create the model and mesh with the box scorec core tool
  mpirun -n $NUM_PROCS \
    box \
    $VALUE    $VAR $VALUE \
    0.01 1    0.01 \
    1 aspect_rat_${AR}_model_${VALUE}_.dmg aspect_rat_${AR}_mesh_${VALUE}_.smb 

  # Repartition to the full number of processors,
  # Overwrite the smb file with the repartitioned mesh
  mpirun -n $NUM_PROCS \
    repartition aspect_rat_${AR}_model_${VALUE}_.dmg $NUM_PROCS \
      aspect_rat_${AR}_mesh_${VALUE}_.smb   \
      aspect_rat_${AR}_mesh_${VALUE}_.smb 

  (( AR++ ))
done

echo 
echo Completed linear mesh and model creation.
echo 

# Move to quadratic Directory, copy linear meshes
cd $QUADRATIC_DIR
cp $LINEAR_DIR/*  $QUADRATIC_DIR

# Convert meshes to use quadratic shape functions
AR=1
for (( i=0; i<$NUM_MESHES; i++))
do
  # Convert the  meshes to use 2nd order shape functions
  mpirun -n $NUM_PROCS \
    ${LIN2QUAD_EXEC} \
    aspect_rat_${AR}_model_${VALUE}_.dmg aspect_rat_${AR}_mesh_${VALUE}_.smb

  # Repartition to the full number of processors,
  # Overwrite the smb file with the repartitioned mesh.
  # May be redundant but best to be safe
  mpirun -n $NUM_PROCS \
    repartition aspect_rat_${AR}_model_${VALUE}_.dmg $NUM_PROCS \
      aspect_rat_${AR}_mesh_${VALUE}_.smb   \
      aspect_rat_${AR}_mesh_${VALUE}_.smb 

  (( AR++ ))
done

cd $CONVERGENCE_DIR
export MESHES_PREPED=true

