#!/bin/bash

CONVERGENCE_DIR=/home/jlclough/research/high_speed_panel/tet_convergence
TESTING_DIR=$CONVERGENCE_DIR/testing
LINEAR_DIR=$TESTING_DIR/linear
QUADRATIC_DIR=$TESTING_DIR/quadratic
LIN2QUAD_EXEC=/home/jlclough/research/high_speed_panel/linear_to_quad/build/src/linear_to_quad

export NUM_MESHES=4
export NUM_PROCS=4

# First make basic linear meshes for composite tets
cd $LINEAR_DIR

VALUE=1
V10=10
for (( i=0; i<$NUM_MESHES; i++))
do
  # Create the model and mesh with the box scorec core tool
    box \
    $VALUE $V10 $VALUE \
    0.01   1    0.01 \
    1 beam_model_${VALUE}_.dmg beam_mesh_${VALUE}_.smb 

  # Repartition to the full number of processors,
  # Overwrite the smb file with the repartitioned mesh
  mpirun -n $NUM_PROCS \
    repartition beam_model_${VALUE}_.dmg 1 \
      beam_mesh_${VALUE}_.smb   \
      beam_mesh_${VALUE}_.smb 


  (( VALUE*=2 ))
  (( V10=VALUE*10 ))
done

echo 
echo Completed linear mesh and model creation.
echo 

# Move to quadratic Directory, copy linear meshes
cd $QUADRATIC_DIR
cp $LINEAR_DIR/*  $QUADRATIC_DIR

# Convert meshes to use quadratic shape functions
VALUE=1
for (( i=0; i<$NUM_MESHES; i++))
do
  for (( j=0; j<$NUM_PROCS; j++))
  do
    mv beam_mesh_${VALUE}_${j}.smb beam_line_${VALUE}_${j}.smb
  done

  # Convert the  meshes to use 2nd order shape functions
  mpirun -n $NUM_PROCS \
    ${LIN2QUAD_EXEC} \
    beam_model_${VALUE}_.dmg beam_line_${VALUE}_.smb beam_mesh_${VALUE}_.smb

  # Repartition to the full number of processors,
  # Overwrite the smb file with the repartitioned mesh.
  # May be redundant but best to be safe
  mpirun -n $NUM_PROCS \
    repartition beam_model_${VALUE}_.dmg $NUM_PROCS \
      beam_mesh_${VALUE}_.smb   \
      beam_mesh_${VALUE}_.smb 

  for (( k=0; k<$NUM_PROCS; k++))
  do
    rm beam_line_${VALUE}_${k}.smb
  done

  (( VALUE*=2 ))
done

cd $CONVERGENCE_DIR
export MESHES_PREPED=true

