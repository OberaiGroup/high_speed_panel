#!/bin/bash
#SBATCH -J quarter_full_7d_16c_tol-4
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2GB
#SBATCH --time=168:00:00
#SBATCH --mail-user=jlclough@usc.edu
#SBATCH --mail-type=all
#SBATCH --account=aoberai_286
#SBATCH --partition=oneweek

module purge
module load gcc/9.2.0
module load openmpi/4.0.2 pmix/3.1.3 cmake/3.15.4 boost/1.70.0

ulimit -s unlimited

export OMP_NUM_THREADS=16

export dir=/project/aoberai_286/jlclough/high_speed_panel/plate_no_stiffeners/creep_only/hpc_long_run/quarter_plate/oneweek

cd $dir

mpirun "-n" 16 $ALBANY_EXE ${dir}/input.yaml 

