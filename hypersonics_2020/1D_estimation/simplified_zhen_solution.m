
% Material parameters
sigma_0 = 22.73E6;
A_bar   = 1.0;
Q       = 251E3;
n       = 12.5;
E       = 113.8E9;
alpha   = 9.7E-6;
R       = 8.3145;
e_0     = 0.0;
nu      = 0.33;

sigma_0 = 1.0;
n       = 12.5;
E       = 5.0E+3;
alpha   = 9.7E-6;
e_0     = 0.0;

kappa = E / ( 3*( 1-2*nu));
mu    = E / ( 2*( 1+nu));
beta  = E / ( 1*( 1-2*nu)) * alpha;

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


% Precompute some values
Q_R     = Q/R;
three_p = 3 + (mu/3)/( kappa + mu/3);
nine_p  = 9 + (mu/3)/( kappa + mu/3);
beta_k  = beta/ ( kappa + mu/3);



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

%  % Cruise
%  dt = 1.0;
%  t_cruise = t_flight - 2*t_ss;
%  nt = t_cruise/dt;
%  I  = length(time);
%  for i = 1:nt
%    time(I+i) = time(I+i-1) + dt;
%  end
%
%  % Landing
%  dt = 0.25;
%  t_start_landing = t_flight - t_ss;
%  nt = (t_flight - t_start_landing)/dt;
%  I  = length(time);
%  for i = 1:nt
%    time(I+i) = time(I+i-1) + dt;
%  end
end


dummy = @(e_c,t) strain_rate( e_c, t, temperature( t, T_0, T_f, t_ss, t_flight), T_0, E, nu, Q, R, alpha, sigma_0, A_bar, n);

[e_c_sol] = lsode( dummy, e_0, time);

for i = 1:length(time)
  T(i)         = temperature( time(i), T_0, T_f, t_ss, t_flight);
  sigma(i)     = -E * ( alpha* (T(i) - T_0) + e_c_sol(i));
  sig_ratio(i) = sigma(i)/sigma_0;

  DT         = T(i) - T_0;
  kappa_term = (kappa - 2*mu/3)/(kappa-beta*DT+mu/3);

  %first  = beta * DT *( kappa_term -1);
%  first  = beta * 2 * DT *( kappa_term -1);
%  second = mu * e_c_sol(i)*(2+ kappa_term);

  bot    = kappa + mu/3.0;
  DT     = T(i) - T_0;
  first  = -beta*2*DT*mu/bot;
  second = e_c_sol(i)* 3*mu* kappa /bot;

  tau_11(i) =  first - second;

  tau_11_norm(i) = tau_11(i)/sigma_0;
end
%temp_time      = [time', T'];
%sig_time       = [time', sigma'/1E9];
%sig_ratio_time = [time', sig_ratio'];

%% fudge factor to plot post-steady state results
%ff = 2.0;
%ff_td = 2.0;
%j = 1;
%if n_flight == 2
%  for i = 1:length(time)
%    if time(i) < ff*t_ss; % takeoff
%      t_take_off(i) = time(i);
%      e_c_take_off(i) = e_c_sol(i);
%    elseif ( t_flight-ff_td*t_ss < time(i)) && (time(i) < t_flight + ff_td*t_ss); %land and take off
%      t_touch_down(j) = time(i);
%      e_c_touch_down(j) = e_c_sol(i);
%      j = j+1;
%    end
%  end
%  takeoff_solution   = [t_take_off',   e_c_take_off'*100];
%  touchdown_solution = [t_touch_down', e_c_touch_down'*100];
%end




