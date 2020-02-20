
function e_c_dot = strain_rate( e_c, t, T, T_0, E, nu, Q, R, alpha, sigma_0, A_bar, c_1)

  kappa = E / ( 3*( 1-2*nu));
  mu    = E / ( 2*( 1+nu));
  beta  = E / ( 1*( 1-2*nu)) * alpha;

  DT = T - T_0;

  leading  = A_bar/3 * exp( -Q/(R*T));

  constant = ( 2 * mu/(3*sigma_0))^c_1;

%  diff_1 = e_c*( 3 - mu/(kappa - beta*DT + mu/3));
%  diff_2 = beta *2 * DT/(kappa - beta*DT + mu/3);

  bot    = kappa + mu/3.0;
  diff_1 = -beta*2*DT/bot;
  diff_2 = -e_c* 3* kappa /bot;
  

  diff = diff_1 + diff_2;

  abs_val = abs( diff)^c_1;

  sign_val = sign( diff);


  e_c_dot = leading * constant * abs_val * sign_val;
end
