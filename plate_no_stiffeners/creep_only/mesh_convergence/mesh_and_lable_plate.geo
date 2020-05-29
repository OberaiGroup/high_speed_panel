// First load the wing OML, ribs, and spars
SetFactory("OpenCASCADE");

panel_v() = ShapeFromFile( "plate_no_stiffeners.stp");

Physical Surface("x_min") = {1};
Physical Surface("y_min") = {2};
Physical Surface("top")   = {3};
Physical Surface("y_max") = {4};
Physical Surface("ring")  = {5};
Physical Surface("x_max") = {6};
Physical Surface("bottom_inside_ring") = {7};


// Define Mesh Parameters
// Mesh.CharacteristicLengthMax = 1.0;
Mesh.SaveAll = 1;

// Set mesh output style: 
// 1 for .msh, 16 for .vtk (for use with paraview)
//Mesh.Format = 16;
Mesh.Format = 1;
Mesh 2;
Save Sprintf("mesh_1.msh");
RefineMesh;
Save Sprintf("mesh_2.msh");
RefineMesh;
Save Sprintf("mesh_3.msh");
