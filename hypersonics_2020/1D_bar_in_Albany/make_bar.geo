
// Run with:
//
// gmsh_4_2 make_bar.geo -3 -order 2
//
// to make a second order 3D mesh of the bar.

SetFactory("OpenCASCADE");

// box origin
x = 0.0;
y = 0.0; 
z = 0.0;

// box side lengths
dx = 1.0;
dy = 0.1;
dz = 0.1;


Box( 1) = { x, y, z, dx, dy, dz};

Physical Surface("min_x") = { 1};
Physical Surface("max_x") = { 2};
Physical Surface("min_z") = { 3};
Physical Surface("min_y") = { 5};


Mesh.CharacteristicLengthMax = 0.05;
Mesh.SaveAll=1;
// Uncomment for vtk files.
// Leave commented for .msh files
// Mesh.Format=16;
