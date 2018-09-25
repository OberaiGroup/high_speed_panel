% Prep workspace
clear
graphics_toolkit('gnuplot');


% Beam geometry
%   - Approximate geometry of one hat-stiffened section 
%      from Plews and Duartes used
%   - Hat approximated as c-channel
%   - Cross-section modeled in ESP for I and A
L = 0.1397; % meters
   % parallel-to-stream length of panel
I = 1.038E-7; % (meters)^4
A = 1.159E-4; % (meters)^2

% Material Properties
%   - Ti6Al4V used from ASM Materials
E = 113.8E+9; % Newton/(meters)^2
rho = 4430; % Kilogram/(meters)^3

% Fluid properties
beta = 0.0; % Kg/meter
     % Inertial effects of fluid
Cp   = 1.0; % unitless
     % Coefficient of pressure

% Lower and upper range to look for roots
lambda_low = 0.0;
lambda_high = 10.0;

% Condense problem parameters
a = 2 * Cp / (E * I);

function beta_1 = calc_beta_1( a, w)

  top = 4 * (2/3)^(1/3) * w^2;

  bot_in = 27 * a^2 - 256 * a^3 * w^3;

  bot_cub = 9 * a + (3 * bot_in)^(1/2);

  bot = bot_cub^(1/3);

  beta_1 = top / bot;
end

function beta_2 = calc_beta_2( a, w)

  top_in = 27 * a^2 - 256 * a^3 * w^3;

  top_cub = 9 * a + (3 * top_in)^(1/2);

  top = top_cub^(1/3);
  
  bot = 2^(1/3) * 3^(2/3) * a;

  beta_2 = top / bot;

end

function p = calc_p( a, w)

  beta1 = calc_beta_1( a, w);
  beta2 = calc_beta_2( a, w);

  p = beta1 + beta2;
end

function alpha = calc_alphas( a, w)

  p = calc_p( a, w);
  q = sqrt( p);
  half = 1/2;

  first = half * p;
  second = 2 / ( a * q);

  alpha = zeros( 1, 4);
  alpha(1) = -first - half * sqrt( -p - second);
  alpha(2) = -first + half * sqrt( -p - second);
  alpha(3) =  first - half * sqrt( -p + second);
  alpha(4) =  first + half * sqrt( -p + second);

end

function val = find_my_roots( a, w, L);

  alpha = calc_alphas( a, w);

  eaL  = zeros( 1, 4);
  aeaL = zeros( 1, 4);
  for i = 1:4
    eaL(i) = exp( alpha( i) * L);
    aeaL(i) = alpha(i) * eaL(i);
  end

  r4134 = (alpha(4) - alpha(1))/(alpha(3) - alpha(4));
  r4234 = (alpha(4) - alpha(2))/(alpha(3) - alpha(4));

  first = aeaL(1) + r4134 * (aeaL(3) - aeaL(4)) - aeaL(4);

  sec_top = eaL(1) + r4134 * (eaL(3) - eaL(4)) - eaL(4);
  sec_bot = eaL(2) + r4234 * (eaL(3) - eaL(4)) - eaL(4);

  second = sec_top / sec_bot;

  third = aeaL(2) + r4234 * (aeaL(3) - aeaL(4)) - aeaL(4);

  val = first - second * third;

end

w_n = 200;
w_0 = 0;
w_N = 4;
w_delta = (w_N - w_0)/w_n;
wi_n = 200;
wi_0 = 0;
wi_N = 4;
wi_delta = (wi_N - wi_0)/wi_n;
w = zeros( wi_n+1, w_n+1);
f = zeros( wi_n+1, w_n+1);
f_norm = zeros( wi_n+1, w_n+1);
for i = 1:w_n+1
  for j = 1: wi_n+1
    w(i,j) = w_0 + w_delta * (i-1) + (wi_0 + wi_delta * (j-1))*sqrt(-1);
    f(i,j) = find_my_roots( a, w(i,j), L);
    f_norm(i,j) = norm( f(i,j), 2);
    if f_norm(i,j) > 10
      f_norm(i,j) = 10;
    end 
  end
end

mesh( real(w(:,1)), imag(w(1,:)), f_norm);
title( 'norm f and w');
xlabel( 'Real w');
ylabel( 'Imag w');
zlabel( 'norm f(w)');

printf( 'The mininum of f_norm = \n');
min( min(f_norm))
printf( '\n\n');

printf( 'Found at: w = \n');
[MIN, IND] = min( f_norm(:))
[row, col] = ind2sub( size(f_norm), IND)
w( row, col)


%fun = @(x) find_my_roots( a, x, L);

%roots = fzero( fun, [-100, 100]);
