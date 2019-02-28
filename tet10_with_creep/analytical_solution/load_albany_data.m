clear
hold off
close all

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




function out = eq_100( y, t, kappa, mu, temp_change, alpha_hat, beta)

  beta_hat = y(1);
  delta = y(2);

  term_1 = kappa / 2.0 * ( (alpha_hat * beta_hat.^2)^2 -1 );
  term_2 = mu / 3.0 * ( alpha_hat^(-2/3) * beta_hat.^(2/3) .* delta -alpha_hat^(4/3) * beta_hat.^(-4/3) .* delta.^(-2) );
  term_3 = alpha_hat * beta_hat.^2 * beta * temp_change;

  out = term_1 + term_2 - term_3;
end

function delta_dot = eq_102( y, t, B, mu, c_1, alpha_hat)

  beta_hat = y(1);
  delta    = y(2);

  leading_term = sqrt(2/27) * B * mu^c_1;

  diff_1 = 2/3 * alpha_hat^(4/3) .* beta_hat.^(-4/3) * delta.^(-2);
  diff_2 = 2/3 * alpha_hat*(-2/3).* beta_hat.^(2/3)  * delta;

  trailing_term = delta + 2 * alpha_hat^2 * beta_hat .* delta.^(4);

  delta_dot = leading_term * abs( diff_1 - diff_2) * trailing_term;
end


function out = solution( y, t)
  % y = ( beta_hat, delta, stress, gamma)

  % Set Problem parameters
  time_start  = 0.0;
  time_finish = 5.0;

  temperature_0 = 443; % K
  
  % material properties
  young_modulus = 4.52E+4; % MPa
  poisson_ratio = 0.33;
  linear_cte    = 2.2E-5;  % 1/K

  A_bar   = 1.0;
  sigma_0 = 25.66; % MPa
  c_1     = 9.7;
  

  kappa = young_modulus / (3 * (1 - 2 * poisson_ratio));
  mu    = young_modulus / (2 * (1 + poisson_ratio));
  beta  = young_modulus * linear_cte / (1 - 2*poisson_ratio);

  alpha_hat   = get_alpha_hat( t);
  temperature = get_temperature( %TODO, t);
  B           = get_B( A_bar, sigma_0, c_1, Q_over_R, temperature);
  temp_change


  out(1) = eq_100( y, t, kappa, my, temp_change, alpha_hat);
  out(2) = eq_102( y, t, B, mu, c_1, alpha_hat)


end

% Gets the analytical solution for finite yield with or without temperature change
function [stress, time] = get_constTemp__analytical_solution()


end


% Read in raw data files
constTemp_data_raw = csvread( "../albany_beam/constTemp_data0.0.csv");
changeTemp_data_raw = csvread( "../albany_beam/changeTemp_data0.00.0.csv");

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
[analytical_changeTemp_stress, analytical_changeTemp_time] = get_changeTemp_analytical_solution(); 


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
