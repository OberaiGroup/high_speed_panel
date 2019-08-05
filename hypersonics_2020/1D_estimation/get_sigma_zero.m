% Point 0: Origin of data
% Point 1: One unit in the X direction
% Point 2: One unit in the Y direction
% Rest of points on the line to estimate

%% Inputs
data_file_name = 'curve_points_data.csv';
X_ref_value    = 2;  % hr
Y_ref_value    = 10; % % (percent)


%% Read ImageJ data in 
raw_data = csvread( data_file_name);

point_number = raw_data(:, 1);
X_px         = raw_data(:, 6);
Y_px         = raw_data(:, 7);
clear raw_data


%% Translate to true origin
origin_px = [X_px(1), Y_px(1)];
for i=1:length( X_px)
  X_px(i) = X_px(i) - origin_px(1);
  Y_px(i) = Y_px(i) - origin_px(2);
end

% Flip Y axis to point up instead of down
Y_px = -Y_px;

%% Scale data 
x_ref_px  = [X_px(2), Y_px(2)];
y_ref_px  = [X_px(3), Y_px(3)];

X_ref = X_ref_value;
Y_ref = Y_ref_value;

x_dist_px = sqrt( x_ref_px(1)^2 + x_ref_px(2)^2);
y_dist_px = sqrt( y_ref_px(1)^2 + y_ref_px(2)^2);

px_to_hr      = X_ref/x_dist_px;
px_to_percent = Y_ref/y_dist_px;

time  = X_px(4:end)*px_to_hr;
creep = Y_px(4:end)*px_to_percent;

% figure 
% scatter( time, creep)
% hold on
% grid on
% title( 'Data Directly from Figure 4 in Lavina et al.')
% xlabel( 'Time [hr]')
% ylabel( 'Creep Strain (%)')

%% Linear regression

% convert time from hours to seconds
time = time * 3600;

slope = time\creep;

figure
scatter( time, creep)
hold on
plot( time, slope*time)
grid on
title( 'Creep Strain over Time')
xlabel( 'Time [s]')
ylabel( 'Creep Strain [%]')
legend( 'Experimental Data (Lavina et al.)', 'Linear Regression')


%% Estimate sigma_0
Q       = 251E3;
n       = 12.5;
R       = 8.3145;
T       = 873;
sigma   = 200E6;
A_bar   = 1;


exponent = exp( -Q/(R*T));
top      =  A_bar * exponent * sigma^n;

sigma_0 = (top/slope)^(1/n)
% sigma_0 = 22.73 MPa

