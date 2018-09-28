#!/bin/bash

if [ $MESHES_PREPED]
  CONVERGENCE_DIR=/home/jlclough/research/high_speed_panel/tet_convergence
  TESTING_DIR=$CONVERGENCE_DIR/testing
  LINEAR_DIR=$TESTING_DIR/linear
  QUADRATIC_DIR=$TESTING_DIR/quadratic
  RESULTS_DIR=$TESTING_DIR/results

  # Move to results direcotry
  cd $RESULTS_DIR

  # Copy base input files, also comp_material.yaml
  cp $CONVERGENCE_DIR/base_*             $RESULTS_DIR
  cp $CONVERGENCE_DIR/comp_material.yaml $RESULTS_DIR

  # For each mesh, modify base_input.yaml to run with that mesh

else
  echo "Run make_meshes.sh first!"
fi
