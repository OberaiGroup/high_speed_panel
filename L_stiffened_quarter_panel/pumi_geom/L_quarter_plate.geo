Point(13) = {0.152400,0.001651,-0.031750,0.100000};
Point(14) = {0.152400,0.003302,-0.031750,0.100000};
Point(16) = {0.001651,0.001651,-0.031750,0.100000};
Point(15) = {0.001651,0.003302,-0.031750,0.100000};
Point(11) = {0.000000,0.127000,0.001651,0.100000};
Point(9) = {0.152400,0.127000,0.001651,0.100000};
Point(10) = {0.152400,0.000000,0.001651,0.100000};
Point(12) = {0.000000,0.000000,0.001651,0.100000};
Point(3) = {0.152400,0.003302,0.000000,0.100000};
Point(4) = {0.152400,0.127000,0.000000,0.100000};
Point(1) = {0.152400,0.000000,0.000000,0.100000};
Point(2) = {0.152400,0.001651,0.000000,0.100000};
Point(8) = {0.001651,0.001651,0.000000,0.100000};
Point(7) = {0.001651,0.003302,0.000000,0.100000};
Point(5) = {0.001651,0.127000,0.000000,0.100000};
Point(0) = {0.000000,0.000000,0.000000,0.100000};
Point(6) = {0.000000,0.127000,0.000000,0.100000};
Line(37) = {14,3};
Line(38) = {13,2};
Line(40) = {1,10};
Line(41) = {4,9};
Line(35) = {16,8};
Line(36) = {15,7};
Line(42) = {6,11};
Line(39) = {0,12};
Line(31) = {16,13};
Line(32) = {13,14};
Line(33) = {14,15};
Line(34) = {15,16};
Line(30) = {11,12};
Line(29) = {9,11};
Line(28) = {10,9};
Line(27) = {12,10};
Line(21) = {7,3};
Line(22) = {3,4};
Line(23) = {4,5};
Line(17) = {0,1};
Line(18) = {1,2};
Line(19) = {2,8};
Line(20) = {8,7};
Line(24) = {5,7};
Line(25) = {5,6};
Line(26) = {6,0};
Line Loop(63) = {23,25,42,-29,-41};
Line Loop(61) = {21,-37,33,36};
Line Loop(59) = {19,-35,31,38};
Line Loop(57) = {-39,17,40,-27};
Line Loop(55) = {41,-28,-40,18,-38,32,37,22};
Line Loop(53) = {20,-36,34,35};
Line Loop(51) = {26,39,-30,-42};
Line Loop(49) = {-34,-33,-32,-31};
Line Loop(47) = {27,28,29,30};
Line Loop(45) = {-24,-23,-22,-21};
Line Loop(43) = {-26,-25,24,-20,-19,-18,-17};
Plane Surface(64) = {63};
Plane Surface(62) = {61};
Plane Surface(60) = {59};
Plane Surface(58) = {57};
Plane Surface(56) = {55};
Plane Surface(54) = {53};
Plane Surface(52) = {51};
Plane Surface(50) = {49};
Plane Surface(48) = {47};
Plane Surface(46) = {45};
Plane Surface(44) = {43};
Surface Loop(65) = {44,46,48,50,52,54,56,58,60,62,64};
Volume(66) = {65};
Physical Point(13) = {13};
Physical Point(14) = {14};
Physical Point(16) = {16};
Physical Point(15) = {15};
Physical Point(11) = {11};
Physical Point(9) = {9};
Physical Point(10) = {10};
Physical Point(12) = {12};
Physical Point(3) = {3};
Physical Point(4) = {4};
Physical Point(1) = {1};
Physical Point(2) = {2};
Physical Point(8) = {8};
Physical Point(7) = {7};
Physical Point(5) = {5};
Physical Point(0) = {0};
Physical Point(6) = {6};
Physical Line(37) = {37};
Physical Line(38) = {38};
Physical Line(40) = {40};
Physical Line(41) = {41};
Physical Line(35) = {35};
Physical Line(36) = {36};
Physical Line(42) = {42};
Physical Line(39) = {39};
Physical Line(31) = {31};
Physical Line(32) = {32};
Physical Line(33) = {33};
Physical Line(34) = {34};
Physical Line(30) = {30};
Physical Line(29) = {29};
Physical Line(28) = {28};
Physical Line(27) = {27};
Physical Line(21) = {21};
Physical Line(22) = {22};
Physical Line(23) = {23};
Physical Line(17) = {17};
Physical Line(18) = {18};
Physical Line(19) = {19};
Physical Line(20) = {20};
Physical Line(24) = {24};
Physical Line(25) = {25};
Physical Line(26) = {26};
Physical Surface(64) = {64};
Physical Surface(62) = {62};
Physical Surface(60) = {60};
Physical Surface(58) = {58};
Physical Surface(56) = {56};
Physical Surface(54) = {54};
Physical Surface(52) = {52};
Physical Surface(50) = {50};
Physical Surface(48) = {48};
Physical Surface(46) = {46};
Physical Surface(44) = {44};
Physical Volume(66) = {66};



//// Added by hand to control meshing

inches_per_meter = 39.3701;

// l_full = 12.0/inches_per_meter; // length in x
// w_full = 10.0/inches_per_meter; // width in y
// t      = 0.065/inches_per_meter; // thickness in z

l = 0.1524   // meters
w = 0.1270   // meters
t = 0.001651 // meters
h = 0.03175  // meters

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
Field[1].F = "((0.05-0.01)/(0.1524)*x+0.01)/4.0";

Field[2] = MathEval;
Field[2].F = "((0.05-0.01)/(0.1270)*y+0.01)/4.0";

Field[3] = Min;
Field[3].FieldsList = {1, 2};

Background Field = 3;

// Set mesh algorithm
Mesh.Algorithm = 7;
