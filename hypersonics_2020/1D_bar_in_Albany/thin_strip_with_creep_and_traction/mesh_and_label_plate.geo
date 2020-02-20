// First load the wing OML, ribs, and spars
SetFactory("OpenCASCADE");

panel_v() = ShapeFromFile( "plate_no_stiffeners.stp");

Physical Surface("front") = {1};
Physical Surface("back")  = {2};
Physical Surface("top")   = {4};


// Define Mesh Parameters
// Mesh.CharacteristicLengthMax = 0.5;

//Field[1] = MathEvalAniso;
//Field[1].m11 = 100000000000.0;
//Field[1].m12 = 0.0;
//Field[1].m13 = 0.0;
//Field[1].m22 = 0.0;
//Field[1].m23 = 0.0;
//Field[1].m33 = 0.0;
//Background Field = 1;



Mesh.SaveAll = 1;


// Set mesh output style: 
// 1 for .msh, 16 for .vtk (for use with paraview)
// Mesh.Format = 16;
Mesh.Format = 1;

Mesh 2;
Save Sprintf("mesh1.msh");
RefineMesh;
Save Sprintf("mesh2.msh");
