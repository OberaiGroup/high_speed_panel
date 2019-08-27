This is an example of using Albany to model the
steady state response of a linear elastic cube 
under a uniform temperature change. The cube begins
at a temperature of 300 and changes to 400.
It is constrained in the x, y, and z directions along
the minimum x, y, and z faces, respectively. 
It has a Young's modulus, Poisson's ration, 
and coefficient of thermal expansion of
1000, 0.25, and 1E-6, respectively.

Files included:
 - README: This file.
 - box.geo: A gmsh script to create the needed mesh.
 - box.msh: The mesh from gmsh that Albany reads.
 - input.yaml: The main input file to Albany with
    descriptions of the boundary conditions, file names,
    and solver parameters.
 - material.yaml: The secondary input file to Albany 
    with material property information.
 - results.exo: The results that you should expect 
    for this problem.

To run, simply use:

$ /path/to/albany_exe input.yaml
