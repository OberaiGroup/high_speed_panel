#!/bin/bash


BASE=/home/jlclough/research/high_speed_panel/beam_for_orazio/simulation_arrays

NUM_PROCS=2

NUM_Q_R=10
NUM_Stresses=10

Min_Q_R=24000
Max_Q_R=36000
Min_Stresses=0.5
Max_Stresses=1.5

Delta_Q_R=$(bc <<< "scale=16; ($Max_Q_R-$Min_Q_R)/($NUM_Q_R-1.0 )" )
Delta_Stresses=$(bc <<< "scale=16; ($Max_Stresses-$Min_Stresses)/($NUM_Stresses-1.0 )" )


# The *2/2 addition forces bc to return a float, not int
q_r=$(bc <<< "scale=1; $Min_Q_R*2/2")
for (( i=0; i<$NUM_Q_R; i++))
do
  
  stress=$(bc <<< "scale=1; $Min_Stresses*2/2")
  for (( j=0; j<$NUM_Stresses; j++))
  do
    # First make a directory for this run
    dir_name=${BASE}/Q_R_${i}_stress_${j};
    mkdir $dir_name;

    # Copy input files to this dir
    cp $BASE/input.yaml              $dir_name/.;
    cp $BASE/mesh_and_label_beam.msh $dir_name/.;

    # Edit template input file
    sed -e "s/SIGMA_0/$stress/"        \
        -e "s/Q_R/$q_r/"               \
        < $BASE/material_template.yaml \
        > $dir_name/material.yaml

    # Move to this run's directory
    cd $dir_name

    # Run simulation
    mpirun -n $NUM_PROCS                   \
        $ALBANY_DEV_EXEC $dir_name/input.yaml  

    wait # wait for job to finish before starting next one

    # Increment Stress value
    stress=$(bc <<< "scale=16; $stress+$Delta_Stresses ")
  done

  # Increment Q_R value
  q_r=$(bc <<< "scale=16; $q_r+$Delta_Q_R ")

done

cd $BASE
