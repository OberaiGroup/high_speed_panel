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

  # Copy base input files, also comp_material.yaml
  cp $CONVERGENCE_DIR/base_*             $RESULTS_DIR
  cp $CONVERGENCE_DIR/comp_material.yaml $RESULTS_DIR

  # For each mesh, modify base_input.yaml to run with that mesh
  NUM=1
  for (( i=0; i<$NUM_MESHES; i++))
  do
    # First run Linear-Composite Tets
    sed -e "s/test.smb/..\/linear\/beam_mesh_${NUM}_.smb/"  \
        -e "s/test.dmg/..\/linear\/beam_model_${NUM}_.dmg/" \
        -e "s/material.yaml/comp_material.yaml/"       \
        -e "s/results.vtk/results_comp_${NUM}.vtk/"    \
        < base_input.yaml                              \
        > input_comp_${NUM}.yaml

    # Second run Quadratic Tets
    sed -e "s/test.smb/..\/quadratic\/beam_mesh_${NUM}_.smb/"  \
        -e "s/test.dmg/..\/quadratic\/beam_model_${NUM}_.dmg/" \
        -e "s/material.yaml/base_material.yaml/"       \
        -e "s/results.vtk/results_quad_${NUM}.vtk/"    \
        < base_input.yaml                              \
        > input_quad_${NUM}.yaml

    (( NUM*=2 ))
  done

  # Now run tests
  NUM=1
  for (( i=0; i<$NUM_MESHES; i++))
  do
    mpirun -n $NUM_PROCS  \
      ${ALBANY_EXEC} input_comp_${NUM}.yaml \
      >> output_comp_${NUM}.txt 2>&1
    wait 

#    mpirun -n $NUM_PROCS  \
#      ${ALBANY_EXEC} input_quad_${NUM}.yaml \
#      >> output_quad_${NUM}.txt 2>&1
#    wait 

    (( NUM*=2 ))
  done

else
  echo "Run make_meshes.sh first!"
fi
