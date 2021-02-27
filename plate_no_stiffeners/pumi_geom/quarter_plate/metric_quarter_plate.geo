Point(22) = {0.000000,0.127000,0.001651,0.100000};
Point(21) = {0.152400,0.127000,0.001651,0.100000};
Point(20) = {0.152400,0.000000,0.001651,0.100000};
Point(19) = {0.000000,0.000000,0.001651,0.100000};
Point(2) = {0.152400,0.127000,0.000000,0.100000};
Point(3) = {0.000000,0.127000,0.000000,0.100000};
Point(6) = {0.001651,0.127000,0.000000,0.100000};
Point(4) = {0.001651,0.001651,0.000000,0.100000};
Point(5) = {0.152400,0.001651,0.000000,0.100000};
Point(1) = {0.152400,0.000000,0.000000,0.100000};
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

Field[1] = MathEval;
Field[1].F = "((0.05-0.01)/(0.1524)*x+0.01)/4.0";

Field[2] = MathEval;
Field[2].F = "((0.05-0.01)/(0.1270)*y+0.01)/4.0";

Field[3] = Min;
Field[3].FieldsList = {1, 2};

Background Field = 3;

// Set mesh algorithm
Mesh.Algorithm = 7;
