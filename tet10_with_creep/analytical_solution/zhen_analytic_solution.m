%% Problem parameters
% Start, final time; seconds
t0 = 0;
tf = 5;

% Start, final temperature; kelvin
T0 = 443;
Tf = 743;

%% Material properties for Tin
% Young's Modulus; MPa
E = 4.52E4;
% Poisson's ratio; unitless
nu = 0.33;
% Yield strength; MPa
sigma_Y = 30;
% Hardening Modulus; MPa
H = 60;
% Linear thermal expansion coeff.; 1/kelvin
alpha_L = 2.2E-5;
% Stress exponent; unitless
c_1 = 9.7;
% Relaxation parameter; 1/second
A_bar = 1.0;
% Reference stress parameter; MPa
sigma_0 = 25.66;
% Activation energy; kJoule/Mole
Q = 31.4;
% Gas Constant; kJoule/(Mole Kelvin)
R = 8.3145E-3;


