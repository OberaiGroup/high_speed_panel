#!/bin/bash

CONVERGENCE_DIR=/home/jlclough/research/high_speed_panel/tet_convergence
TESTING_DIR=$CONVERGENCE_DIR/testing
LINEAR_DIR=$TESTING_DIR/linear
QUADRATIC_DIR=$TESTING_DIR/quadratic
RESULTS_DIR=$TESTING_DIR/results
ALBANY_EXEC='/home/pogo/Albany/build/src/AlbanyT'

if [ "$MESHES_PREPED" = true ]
then
  # Move to results directory
  cd $RESULTS_DIR

  # Copy base input files
  cp $CONVERGENCE_DIR/base_* $RESULTS_DIR

  # For each mesh, modify base_input.yaml to run with that mesh
  NUM=1
  for (( i=0; i<$NUM_MESHES; i++))
  do
    # Create Quadratic Tets input file
    sed -e "s/test.smb/..\/quadratic\/aspect_rat_${NUM}_mesh_4_.smb/"  \
        -e "s/test.dmg/..\/quadratic\/aspect_rat_${NUM}_model_4_.dmg/" \
        -e "s/material.yaml/base_material.yaml/"                       \
        -e "s/results.vtk/results_ar_${NUM}.vtk/"                      \
        < base_input.yaml                                              \
        > input_ar_${NUM}.yaml

    (( NUM++ ))
  done

  # Now run tests
  NUM=1
  for (( i=0; i<$NUM_MESHES; i++))
  do
    mpirun -n $NUM_PROCS  \
      ${ALBANY_EXEC} input_ar_${NUM}.yaml \
       >> output_ar_${NUM}.txt 2>&1
    wait 

    (( NUM++ ))
  done

else
  echo "Run make_meshes.sh first!"
fi
