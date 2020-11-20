from glob import glob
from shutil import copyfile
import os


subdirs = glob( '*/')

cwd = os.getcwd()

mesh = glob( './panel_*.msh')[0]
mat_yaml = "material.yaml"
input_yaml = "input.yaml"
slurm_scpt = "run_albany_speedup_template.sh"

for dir in subdirs:
  nodes = dir.split("_")[0]
  tasks = dir.split("_")[1]
  tasks = tasks[:-1]

  copyfile( mesh, dir+mesh)
  copyfile( mat_yaml, dir+mat_yaml)
  copyfile( input_yaml, dir+input_yaml)

  new_script_name = "run_albany_speedup_" + nodes + "_" + tasks + ".sh"

  file_in  = open( cwd+"/"+slurm_scpt, 'r')
  file_out = open( cwd+"/"+dir+"/"+new_script_name, 'w')

  lines_in = file_in.readlines()

  job_name = "quarter_scaling_" + nodes + "_" + tasks

  for line in lines_in:
    line = line.replace( "NODES", nodes)
    line = line.replace( "TASKS", tasks)
    line = line.replace( "NAME",  job_name)

    file_out.write( line)
  file_out.close()
