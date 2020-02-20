clear
hold off
close all



% Read in raw data files
constTemp_data_raw = csvread( "../albany_beam/matlab_friendly_constTemp.csv");
changeTemp_data_raw = csvread( "../albany_beam/matlab_friendly_changeTemp.csv");

% want only max cauchy and time
constTemp_cauchy_nonDim = constTemp_data_raw(:, 6);
constTemp_time = constTemp_data_raw(:, 17);
changeTemp_cauchy_nonDim = changeTemp_data_raw(:, 6);
changeTemp_time = changeTemp_data_raw(:, 38);

% Need to re-dimensionalize stress
sigma_0 = 25.66; % MPa
constTemp_cauchy = constTemp_cauchy_nonDim * sigma_0;
changeTemp_cauchy = changeTemp_cauchy_nonDim * sigma_0;

% % Plot stress over time
% figure
% plot( constTemp_time, constTemp_cauchy, 'kd');
% hold on
% plot( changeTemp_time, changeTemp_cauchy, 'bd');
% title("Axial Stress over time")
% xlabel("Time [sec]")
% ylabel("Cauchy Stress, Axial Component [MPa]")
% legend("Constant Temperature", "Changing Temperature" )
% saveas( gcf, "Stress_time.png" )

% Create a strain vector based on strain rate and time
strain_rate = 0.04; % 1/second
constTemp_strain = strain_rate * constTemp_time;
changeTemp_strain = strain_rate * changeTemp_time;

% Get analytical solutions
[analytical_constTemp_stress, analytical_constTemp_time] = get_constTemp_analytical_solution();
% [analytical_changeTemp_stress, analytical_changeTemp_time] = get_changeTemp_analytical_solution(); 


% Plot stress over strain
figure
plot( constTemp_strain, constTemp_cauchy, 'kd');
hold on
plot( changeTemp_strain, changeTemp_cauchy, 'bd');
title("Axial Stress over Strain")
xlabel("Strain")
ylabel("Cauchy Stress, Axial Component [MPa]")
legend("Constant Temperature", "Changing Temperature" )
saveas( gcf, "Stress_strain.png" )
close


%% End of script
%% Begin functions

% Gets the temperature for given case and time
function temperature = get_temperature( change_temp, time)

  % Time range
  t0 = 0.0;
  tf = 5.0;

  % Temperature range
  T0 = 443; 
  Tf = 743;
  
  rate = (Tf - T0)/(tf - t0);

  if (change_temp)
    temperature = T0 + rate * time;
  else
    temperature = T0;
  end
end

% Gets the alpha_hat deflection for a given time
function alpha_hat = get_alpha_hat( time)

  % Time range
  t0 = 0.0;
  tf = 5.0;

  % alpha_hat range
  a0 = 0.0; 
  af = 0.2;
  
  rate = (af - a0)/(tf - t0);

  alpha_hat = a0 + rate * time;
end

function B = get_B( A_bar, sigma_0, c_1, Q_over_R, temperature)

  B = A_bar * sigma_0 / (c_1 + 1.0) *exp( - Q_over_R / temperature);
  

end

function out = eq_100( t, y, kappa, mu, temp_change, alpha_hat, beta)

  beta_hat = y(1);
  delta = y(2);

  term_1 = kappa / 2.0 * ( (alpha_hat * beta_hat.^2)^2 -1 );
  term_2 = mu / 3.0 * ( alpha_hat^(-2/3) * beta_hat.^(2/3) .* delta -alpha_hat^(4/3) * beta_hat.^(-4/3) .* delta.^(-2) );
  term_3 = alpha_hat * beta_hat.^2 * beta * temp_change;

  out = term_1 + term_2 - term_3;

  sprintf('eq_100 out= %d', out);
end

function delta_dot = eq_102( t, y, B, mu, c_1, alpha_hat, sigma_0, K)

  beta_hat = y(1);
  delta    = y(2);
  stress   = y(3);
  gamma    = y(4);

  sqrt_2_27 = sqrt(2/27);

  leading_term = B * mu^c_1;

  diff_1 = 2/3 * alpha_hat^(4/3) .* beta_hat.^(-4/3) * delta.^(-2);
  diff_2 = 2/3 * alpha_hat*(-2/3).* beta_hat.^(2/3)  * delta;

  abs_diff = abs( diff_1 - diff_2).^c_1;

  middle = leading_term * abs_diff + gamma;

  trailing_term = delta + 2 * alpha_hat^2 * beta_hat .* delta.^(4);


  delta_dot = sqrt_2_27 * middle * trailing_term;

  sprintf('eq_102 delta_dot= %d', delta_dot);
end

function stress_dot = eq_103( t, y, K, sigma_0)

  stress = y(3);
  gamma  = y(4);

  if (stress <= sigma_0)
    gamma = 0;
    y(4)  = 0;
  end

  stress_dot = sqrt(3/2) * gamma * K;

  sprintf('eq_103 stress_dot= %d', stress_dot);
end

function out = eq_104( t, y, alpha_hat, kappa, mu, beta, temp_change )

  beta_hat = y(1);
  delta    = y(2);
  stress   = y(3);

  term_1 = kappa/2 * ( ( alpha_hat * beta_hat.^2).^2 - 1);

  term_2_a = alpha_hat^(4/3) * beta_hat.^(-4/3) * delta.^(-2);
  term_2_b = alpha_hat * beta_hat.^(4) * delta;

  term_2 = mu/3 * (term_2_a - term_2_b);

  term_3 = alpha_hat * beta_hat.^(2) * beta * temp_change;

  out = term_1 + term_2 - term_3 - stress;

  sprintf('eq_104 out= %d', out);
end

function out = solution_constant_temp( t, y)
  % y = ( beta_hat, delta, stress, gamma)

  % Set Problem parameters

  temperature_0 = 443; % K
  
  % material properties
  young_modulus = 4.52E+4; % MPa
  poisson_ratio = 0.33;
  linear_cte    = 2.2E-5;  % 1/K
  K             = 60.0;    % MPa

  A_bar    = 1.0;
  sigma_0  = 25.66; % MPa
  c_1      = 9.7;
  Q_over_R = 3776.5; % K
  

  kappa = young_modulus / (3 * (1 - 2 * poisson_ratio));
  mu    = young_modulus / (2 * (1 + poisson_ratio));
  beta  = young_modulus * linear_cte / (1 - 2*poisson_ratio);

  alpha_hat   = get_alpha_hat( t);
  temperature = temperature_0;
  temp_change = temperature - temperature_0;
  B           = get_B( A_bar, sigma_0, c_1, Q_over_R, temperature);


  out =[eq_100( t, y, kappa, mu, temp_change, alpha_hat, beta);
        eq_102( t, y, B, mu, c_1, alpha_hat, sigma_0, K);
        eq_103( t, y, K, sigma_0);
        eq_104( t, y, alpha_hat, kappa, mu, beta, temp_change);];

end

% Gets the analytical solution for finite yield with or without temperature change
function [stress, time] = get_constTemp_analytical_solution()

  % Evaluation time
  time_start  = 0.01;
  time_finish = 5.0;
  time_step   = 0.01;
  time_span = [time_start: time_step: time_finish];

  % Initial Condition
  y0 = [0; 0; 0; 0];

  % Mass matrix
  M = [ 0 0 0 0; 
        0 1 0 0;
        0 0 1 0;
        0 0 0 0];


  sprintf('trying solution with y0 = zeros(4)')
  out = solution_constant_temp( 0.001, y0);
  sprintf(' out(1) = %d \n', out(1))
  sprintf(' out(2) = %d \n', out(2))
  sprintf(' out(3) = %d \n', out(3))
  sprintf(' out(4) = %d \n', out(4))

  pause

  yf = fsolve( @solution_constant_temp, y0);
  sprintf('trying solution with yf = fsolve')
  out = solution_constant_temp( 0.001, yf);
  sprintf(' out(1) = %d \n', out(1))
  sprintf(' out(2) = %d \n', out(2))
  sprintf(' out(3) = %d \n', out(3))
  sprintf(' out(4) = %d \n', out(4))
  pause

  options = odeset( 'Mass', M, 'MassSingular', 'yes', 'RelTol', 1e-4);
  [t, y] =  ode23t( @solution_constant_temp, time_span, y0, options);

  stress = y(:,3);
  time   = t;

end
