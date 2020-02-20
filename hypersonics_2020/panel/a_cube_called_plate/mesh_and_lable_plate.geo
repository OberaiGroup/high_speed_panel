// First load the wing OML, ribs, and spars
SetFactory("OpenCASCADE");

panel_v() = ShapeFromFile( "plate_no_stiffeners.stp");

// Physical Surface("front") = {1,  3,  4, 11, 16};
// Physical Surface("back")  = {13, 6, 14, 20, 19};

Physical Surface("front") = {1};
Physical Surface("back")  = {2};


// Define Mesh Parameters
Mesh.CharacteristicLengthMax = 1.0;
Mesh.SaveAll = 1;

// Set mesh output style: 
// 1 for .msh, 16 for .vtk (for use with paraview)
// Mesh.Format = 16;
Mesh.Format = 1;
