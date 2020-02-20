
% Material parameters
sigma_0 = 22.73E6;
Q       = 251E3;
n       = 12.5;
E       = 113.8E9;
alpha   = 9.7E-6;
R       = 8.3145;
e_0     = 0.0;
nu      = 0.33;

% Temperature parameters
T_0     = 294;
T_f     = 1783;

% Time start
t_0 = 0.0;

% Number of flights
n_flight = 2;

% Time to reach stead state temperature
t_ss = 25.0;

% Time of each flight
t_flight = 10* 60;
t_f = t_flight * n_flight;

%% Time step:
dt = 0.1;
nt = (t_f-t_0)/dt;
for i = 1:nt
  time(i) = t_0 + (i-1)*dt;
end


A_creep = 1/sigma_0^n;
for i = 1:length(time)
  T(i) = temperature( time(i), T_0, T_f, t_ss, t_flight);
  
  creep_ish_term = E/(1+nu);
  creep_ish_term = creep_ish_term*( time(i)* A_creep * exp( -Q/(R*T(i))) * (E/(3*(1-nu)))^n)^(-1/(n-1));

  thermal_term   = E * alpha * (T(i)-T_0)/(1-2*nu);

  sigma(i) = creep_ish_term - thermal_term;
end

plot( time, sigma);
hold on 
xlabel("Time [s]");
ylabel("Stress [Pa]");
title("Stress over time");
