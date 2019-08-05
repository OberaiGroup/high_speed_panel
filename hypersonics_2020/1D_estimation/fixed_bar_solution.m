

% Material parameters
sigma_0 = 22.73E6;
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
n_flight = 2;

% Time to reach stead state temperature
t_ss = 25.0;

% Time of each flight
t_flight = 10* 60;
t_f = t_flight * n_flight;


% Precompute some values
stress_ratio   = E/sigma_0;

strain_rate=@(e_c,t) (exp(-Q/(R*temperature(t, T_0, T_f, t_ss, t_flight))) *( stress_ratio*( alpha* (temperature(t, T_0, T_f, t_ss, t_flight) - T_0) - e_c))^n );

%% Time step:
%% Use a fine step for transients and course for steady state
time = t_0;
for i_flight = 1:n_flight
  % Take off
  dt = 0.25;
  nt = (t_ss-t_0)/dt;
  I = size(time);
  for i = 1:nt
    time(I+i) = time(I+i-1) + dt;
  end

  % Cruise
  dt = 1.0;
  t_cruise = t_flight - 2*t_ss;
  nt = t_cruise/dt;
  I  = length(time);
  for i = 1:nt
    time(I+i) = time(I+i-1) + dt;
  end

  % Landing
  dt = 0.25;
  t_start_landing = t_flight - t_ss;
  nt = (t_flight - t_start_landing)/dt;
  I  = length(time);
  for i = 1:nt
    time(I+i) = time(I+i-1) + dt;
  end
end


[e_c_sol] = lsode( strain_rate, e_0, time);
solution = [time', e_c_sol*100];

for i = 1:length(time)
  T(i) = temperature( time(i), T_0, T_f, t_ss, t_flight);
end
temp_time = [time', T'];

dlmwrite( "data/solution.txt", solution, "delimiter", " ");
dlmwrite( "data/temperature.txt", temp_time, "delimiter", " ");

% fudge factor to plot post-steady state results
ff = 2;
ff_td = 5;
j = 1;
if n_flight == 2
  for i = 1:length(time)

    if time(i) < ff*t_ss; % takeoff
      t_take_off(i) = time(i);
      e_c_take_off(i) = e_c_sol(i);
    elseif ( t_flight-ff_td*t_ss < time(i)) && (time(i) < t_flight + ff_td*t_ss); %land and take off
      t_touch_down(j) = time(i);
      e_c_touch_down(j) = e_c_sol(i);
      j = j+1;
    end
  end
  takeoff_solution = [t_take_off', e_c_take_off'*100];
  dlmwrite( "data/takeoff_solution.txt", takeoff_solution, "delimiter", " ");
  touchdown_solution = [t_touch_down', e_c_touch_down'*100];
  dlmwrite( "data/touchdown_solution.txt", touchdown_solution, "delimiter", " ");
end




