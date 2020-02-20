
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

for i = 1:length(time)
  T(i) = temperature( time(i), T_0, T_f, t_ss, t_flight);

  first_term = -2 * E * alpha * (T(i)-T_0)/(1-2*nu);

  middle_first  = 4 * E / (2*(1-2*nu));
  middle_second = 4 * E * alpha * (T(i) - T_0)/(1-2*nu);

  last_top = 6 * alpha * (T(i) - T_0) * (1+nu) - (1-2*nu);

  last_bot = 4*(1+nu) + 3*(1-2*nu)*(1+nu) - 6*(1+nu)*alpha*(T(i) - T_0);

  sigma(i) = first_term + (middle_first - middle_second)*last_top/last_bot;
end

plot( time, sigma);
hold on 
xlabel("Time [s]");
ylabel("Stress [Pa]");
title("Stress over time");
