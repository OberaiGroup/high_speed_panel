// First load the wing OML, ribs, and spars
SetFactory("OpenCASCADE");

panel_v() = ShapeFromFile( "plate_no_stiffeners.stp");

Physical Surface("front") = {1};
Physical Surface("back")  = {2};

Physical Surface("top")   = {6};

Physical Curve("bottom_edges") = {11,2,9,6};

// Define Mesh Parameters
// Mesh.CharacteristicLengthMax = 1.0;
Mesh.SaveAll = 1;

// Set mesh output style: 
// 1 for .msh, 16 for .vtk (for use with paraview)
// Mesh.Format = 16;
Mesh.Format = 1;
Mesh 2;
Save Sprintf("mesh1.msh");
RefineMesh;
Save Sprintf("mesh2.msh");
