// Inches
l = 12.0;   // length in X
w = 10.0;   // width in Y
t =  0.065; // thickness in Z


// Bottom Outside Ring
Point(1) = {0, 0, 0};
Point(2) = {l, 0, 0};
Point(3) = {l, w, 0};
Point(4) = {0, w, 0};

Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 1};

Curve Loop(1) = {1, 2, 3, 4};

// Bottom Inside Ring
Point(5) = {t,   t,   0};
Point(6) = {l-t, t,   0};
Point(7) = {l-t, w-t, 0};
Point(8) = {t,   w-t, 0};

Line(5) = {5, 6};
Line(6) = {6, 7};
Line(7) = {7, 8};
Line(8) = {8, 5};

Curve Loop(2) = {5, 6, 7, 8};

Plane Surface(1) = {2};
Physical Surface("bottom_inside_ring") = {1};

// Create the ring
Plane Surface(2) = {1 , 2};
Physical Surface("ring") = {2};

// Create the top
Point(9)  = {0, 0, t};
Point(10) = {l, 0, t};
Point(11) = {l, w, t};
Point(12) = {0, w, t};

Line(9)  = {9,  10};
Line(10) = {10, 11};
Line(11) = {11, 12};
Line(12) = {12,  9};

Curve Loop(3) = {9, 10, 11, 12};
Plane Surface(3) = {3};
Physical Surface("top") = {3};

// Label side edges
Line(13) = {1,  9};
Line(14) = {2, 10};
Line(15) = {3, 11};
Line(16) = {4, 12};

// Label side surfaces
Curve Loop(4) = {2, 15, -10, -14};
Plane Surface(4) = {4};
Physical Surface("x_max") = {4};

Curve Loop(5) = {13, -12, -16, 4};
Plane Surface(5) = {5};
Physical Surface("x_min") = {5};

Curve Loop(6) = {3, 16, -11, -15};
Plane Surface(6) = {6};
Physical Surface("y_max") = {6};

Curve Loop(7) = {1, 14, -9, -13};
Plane Surface(7) = {7};
Physical Surface("y_min") = {7};

// Create volume
Surface Loop(1) = {-1, -2, 3, 4, 5, 6, 7};
Volume(1) = {1};

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

course = 0.9;
fine   = 0.25;
smoothness = 0.1;
border = 0.25;

Field[1] = Box;
Field[1].Thickness = l*smoothness;
Field[1].VIn  = course;
Field[1].VOut = fine;
Field[1].XMin = l*border;
Field[1].XMax = l*(1-border);
Field[1].YMin = w*border;
Field[1].YMax = w*(1-border);
Field[1].ZMin = -2.0*t;
Field[1].ZMax = +2.0*t;

Background Field = 1;

// Set mesh algorithm
Mesh.Algorithm = 7;

// Set elements to be second order
SetOrder 2;

// Define the mesh to be 3D
Mesh 3;
