// Inches
l_full = 12.0;   // length in X
w_full = 10.0;   // width in Y
t =  0.065; // thickness in Z

// Divide length and width in halve
l = l_full/2.0;
w = w_full/2.0;


// Bottom Edging "L" shape
Point(1) = {0, 0, 0};
Point(2) = {l, 0, 0};
Point(3) = {l, w, 0};
Point(4) = {0, w, 0};
Point(5) = {t, t, 0};
Point(6) = {l, t, 0};
Point(7) = {t, w, 0};

Line(1) = {1, 2};
Line(2) = {2, 6};
Line(3) = {6, 5};
Line(4) = {5, 7};
Line(5) = {7, 4};
Line(6) = {4, 1};

Curve Loop(1) = {1, 2, 3, 4, 5, 6};

Plane Surface(1) = {1};
Physical Surface("ring") = {1};

// Bottom inside, towards center
Line(7) = {6, 3};
Line(8) = {3, 7};

Curve Loop(2) = {7, 8, -4, -3};

Plane Surface(2) = {2};
Physical Surface("bottom_inside_ring") = {2};

// Create the top
Point(8)  = {0, 0, t};
Point(9)  = {l, 0, t};
Point(10) = {l, w, t};
Point(11) = {0, w, t};

Line(9)  = { 8,  9};
Line(10) = { 9, 10};
Line(11) = {10, 11};
Line(12) = {11,  8};

Curve Loop(3) = {9, 10, 11, 12};
Plane Surface(3) = {3};
Physical Surface("top") = {3};

// Label side edges
Line(13) = {1,  8};
Line(14) = {2,  9};
Line(15) = {3, 10};
Line(16) = {4, 11};

// Label side surfaces
Curve Loop(4) = {1, 14, -9, -13};
Plane Surface(4) = {4};
Physical Surface("y_min") = {4};

Curve Loop(5) = {-5, -8, 15, 11, -16};
Plane Surface(5) = {5};
Physical Surface("y_max") = {5};

Curve Loop(6) = {2, 7, 15, -10, -14};
Plane Surface(6) = {6};
Physical Surface("x_max") = {6};

Curve Loop(7) = {-6, 16, 12, -13};
Plane Surface(7) = {7};
Physical Surface("x_min") = {7};

// Create volume
Surface Loop(1) = {-1, -2, 3, 4, -5, 6, -7};
Volume(1) = {1};
Physical Volume("panel") = {1};

////////////////////////////
///Done creating geometry///
///Now to construct mesh////
////////////////////////////



// Field[1] = MathEval;
// Field[1].F = "1.01 -(1/61)*(x-6)^2 - (1/61)*(y-5)^2";
// // Field[1].F = Sprintf("1.01 -(1/%g)*(x-%g/2)^2 - (1/%g)*(y-%g/2)^2", l, l, w, w);

// Background Field = 1;

// Field[1] = MathEval;
// Field[1].F = "2.1 - 4*2/144*(x-6)^4";
// 
// Field[2] = MathEval;
// Field[2].F = "2.1 - 4*2/100*(y-5)^4";
// 
// Field[3] = Min;
// Field[3].FieldsList = {1, 2};
// 
// Background Field = 3;

global_refinement_level = 1.0;
coarse = 0.5*global_refinement_level;
fine   = coarse/5.0;
smoothness = 0.25;
border = 0.25+smoothness/2.0;

Field[1] = Box;
Field[1].Thickness = l_full*smoothness;
Field[1].VIn  = coarse;
Field[1].VOut = fine;
Field[1].XMin = l_full*border;
Field[1].XMax = l_full*(1-border);
Field[1].YMin = w_full*border;
Field[1].YMax = w_full*(1-border);
Field[1].ZMin = -2.0*t;
Field[1].ZMax = +2.0*t;

Background Field = 1;

// Set mesh algorithm
Mesh.Algorithm = 7;

// Set elements to be second order
SetOrder 2;

// Define the mesh to be 3D
Mesh 3;
