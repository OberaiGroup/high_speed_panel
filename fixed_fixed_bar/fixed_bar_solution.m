

% Material parameters
sigma_0 = 18.7E6;
Q       = 251E3;
n       = 12.5;
E       = 113.8E9;
alpha   = 9.7E-6;
R       = 8.3145;
e_0     = 0.0;

% Temperature parameters
T_0     = 294;
T_f     = 1783;

% Time start
t_0 = 0.0;

% Number of flights
n_flight = 1;

% Time to reach stead state temperature
t_ss = 25.0;

% Time of each flight
t_flight = 10* 60;

t_f = t_flight * n_flight;
t_f_focused = 50;

% Time step
dt = 0.25;
nt = (t_f-t_0)/dt;

% Precompute some values
stress_ratio   = E/sigma_0;
thermal_strain = alpha*(T_f - T_0);


strain_rate=@(e_c,t) (exp(-Q/(R*temperature(t, T_0, T_f, t_ss, t_flight))) *( stress_ratio*( alpha* (temperature(t, T_0, T_f, t_ss, t_flight) - T_0) - e_c))^n );


t = linspace( t_0, t_f, nt);
[e_c_sol] = lsode( strain_rate, e_0, t);

solution = [t', e_c_sol*100];
dlmwrite( "data/solution.txt", solution, "delimiter", " ");


nt = (t_f_focused-t_0)/dt;
t = linspace( t_0, t_f_focused, nt);
[e_c_sol] = lsode( strain_rate, e_0, t);
solution = [t', e_c_sol*100];
dlmwrite( "data/focused_solution.txt", solution, "delimiter", " ");
