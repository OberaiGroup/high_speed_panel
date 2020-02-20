SetFactory("OpenCASCADE");

beam_v() = ShapeFromFile( "beam.stp");

Physical Surface("front") = {1};
Physical Surface("back")  = {2};

Physical Surface("top")   = {6};


// Define Mesh Parameters
// Mesh.CharacteristicLengthMax = 1.0;
Mesh.SaveAll = 1;

// Set mesh output style: 
// 1 for .msh, 16 for .vtk (for use with paraview)
// Mesh.Format = 16;
Mesh.Format = 1;
Mesh 2;
RefineMesh;
Save Sprintf("mesh2.msh");
Save Sprintf("mesh2.vtk");
