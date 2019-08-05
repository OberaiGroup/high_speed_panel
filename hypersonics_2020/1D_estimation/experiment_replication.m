

% Material parameters
sigma_0 = 18.7E6;
A_bar   = 1.0;
Q       = 251E3;
n       = 12.5;
R       = 8.3145;
e_0     = 0.0;

% Temperature and load parameters
T = 873;
sigma = 200E6;


% Time start
t_0       = 0.0;
t_f_hours = 8;
t_f       = t_f_hours*3600;

% Time step
dt = 10;
nt = (t_f - t_0)/dt;

time = zeros( nt+1, 1);
e_c  = zeros( nt+1, 1);
for i=1:nt+1
  time( i) = t_0 + (i-1)*dt;


  exponent     = exp( -Q/(R*T));
  stress_ratio = sigma / sigma_0;

  e_c(  i) = A_bar * exponent * (stress_ratio)^n * time(i);
end

plot( time, e_c*100)
hold on
xlabel( 'time [s]')
ylabel( 'Creep Strain (%)')
