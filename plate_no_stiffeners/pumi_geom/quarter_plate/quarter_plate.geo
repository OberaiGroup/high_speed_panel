Point(22) = {0.000000,5.000000,0.065000,0.100000};
Point(21) = {6.000000,5.000000,0.065000,0.100000};
Point(20) = {6.000000,0.000000,0.065000,0.100000};
Point(19) = {0.000000,0.000000,0.065000,0.100000};
Point(2) = {6.000000,5.000000,0.000000,0.100000};
Point(3) = {0.000000,5.000000,0.000000,0.100000};
Point(6) = {0.065000,5.000000,0.000000,0.100000};
Point(4) = {0.065000,0.065000,0.000000,0.100000};
Point(5) = {6.000000,0.065000,0.000000,0.100000};
Point(1) = {6.000000,0.000000,0.000000,0.100000};
Point(0) = {0.000000,0.000000,0.000000,0.100000};
Line(32) = {3,22};
Line(31) = {2,21};
Line(29) = {0,19};
Line(30) = {1,20};
Line(26) = {22,19};
Line(25) = {21,22};
Line(24) = {20,21};
Line(23) = {19,20};
Line(16) = {2,6};
Line(15) = {5,2};
Line(12) = {3,0};
Line(11) = {6,3};
Line(10) = {4,6};
Line(9) = {5,4};
Line(8) = {1,5};
Line(7) = {0,1};
Line Loop(39) = {-12,32,26,-29};
Line Loop(37) = {8,15,31,-24,-30};
Line Loop(35) = {-11,-16,31,25,-32};
Line Loop(33) = {7,30,-23,-29};
Line Loop(27) = {23,24,25,26};
Line Loop(17) = {15,16,-10,-9};
Line Loop(13) = {7,8,9,10,11,12};
Plane Surface(40) = {39};
Plane Surface(38) = {37};
Plane Surface(36) = {35};
Plane Surface(34) = {33};
Plane Surface(28) = {27};
Plane Surface(18) = {17};
Plane Surface(14) = {13};
Surface Loop(41) = {-14,-18,28,34,-36,38,-40};
Volume(42) = {41};
Physical Point(22) = {22};
Physical Point(21) = {21};
Physical Point(20) = {20};
Physical Point(19) = {19};
Physical Point(2) = {2};
Physical Point(3) = {3};
Physical Point(6) = {6};
Physical Point(4) = {4};
Physical Point(5) = {5};
Physical Point(1) = {1};
Physical Point(0) = {0};
Physical Line(32) = {32};
Physical Line(31) = {31};
Physical Line(29) = {29};
Physical Line(30) = {30};
Physical Line(26) = {26};
Physical Line(25) = {25};
Physical Line(24) = {24};
Physical Line(23) = {23};
Physical Line(16) = {16};
Physical Line(15) = {15};
Physical Line(12) = {12};
Physical Line(11) = {11};
Physical Line(10) = {10};
Physical Line(9) = {9};
Physical Line(8) = {8};
Physical Line(7) = {7};
Physical Surface(40) = {40};
Physical Surface(38) = {38};
Physical Surface(36) = {36};
Physical Surface(34) = {34};
Physical Surface(28) = {28};
Physical Surface(18) = {18};
Physical Surface(14) = {14};
Physical Volume(42) = {42};

//// Added by hand to control meshing

l_full = 12.0; // length in x
w_full = 10.0; // width in y
t      = 0.065; // thickness in z

//global_refinement_level = 1.0;
//coarse = 0.5*global_refinement_level;
//fine   = coarse/5.0;
//smoothness = 0.0;
//border = 0.25+smoothness/2.0;
//
//Field[1] = Box;
//// Field[1].Thickness = l_full*smoothness;
//// Field[1].VIn  = coarse;
//Field[1].VIn  = fine*1.5;
//Field[1].VOut = fine;
//Field[1].XMin = l_full*border;
//Field[1].XMax = l_full*(1-border);
//Field[1].YMin = w_full*border;
//Field[1].YMax = w_full*(1-border);
//Field[1].ZMin = -2.0*t;
//Field[1].ZMax = +2.0*t;

coarse = 0.5;
fine   = 0.1;


Field[1] = MathEval;
Field[1].F = "((0.5-0.1)/6.0*x+0.1)/1.25";

Field[2] = MathEval;
Field[2].F = "((0.5-0.1)/5.0*y+0.1)/1.25";

Field[3] = Min;
Field[3].FieldsList = {1, 2};

Background Field = 3;

// Set mesh algorithm
Mesh.Algorithm = 7;

