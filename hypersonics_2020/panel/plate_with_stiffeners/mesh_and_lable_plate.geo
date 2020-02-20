// First load the wing OML, ribs, and spars
SetFactory("OpenCASCADE");

panel_v() = ShapeFromFile( "plate_with_2_stiffeners.stp");

Physical Surface("front") = {1,  3,  4, 11, 16};
Physical Surface("back")  = {13, 6, 14, 20, 19};

Physical Surface("top")   = {12};


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
