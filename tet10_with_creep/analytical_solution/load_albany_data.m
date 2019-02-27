
clear
hold off
close all



constTemp_data_raw = csvread( "../albany_beam/constTemp_data0.0.csv");
changeTemp_data_raw = csvread( "../albany_beam/changeTemp_data0.00.0.csv");
% Row headings are:
% "N","min(Cauchy_Stress_2_02)","q1(Cauchy_Stress_2_02)","med(Cauchy_Stress_2_02)","q3(Cauchy_Stress_2_02)","max(Cauchy_Stress_2_02)","avg(Cauchy_Stress_2_02)","std(Cauchy_Stress_2_02)","min(vtkOriginalCellIds)","q1(vtkOriginalCellIds)","med(vtkOriginalCellIds)","q3(vtkOriginalCellIds)","max(vtkOriginalCellIds)","avg(vtkOriginalCellIds)","std(vtkOriginalCellIds)","vtkValidPointMask","Time"
% want only max cauchy and time
constTemp_cauchy_nonDim = constTemp_data_raw(:, 6);
constTemp_time = constTemp_data_raw(:, 17);
changeTemp_cauchy_nonDim = changeTemp_data_raw(:, 6);
changeTemp_time = changeTemp_data_raw(:, 38);

% Need to re-dimensionalize stress
sigma_0 = 25.66; % MPa
constTemp_cauchy = constTemp_cauchy_nonDim * sigma_0;
changeTemp_cauchy = changeTemp_cauchy_nonDim * sigma_0;

% Plot stress over time
figure
plot( constTemp_time, constTemp_cauchy, 'kd');
hold on
plot( changeTemp_time, changeTemp_cauchy, 'bd');
title("Axial Stress over time")
xlabel("Time [sec]")
ylabel("Cauchy Stress, Axial Component [MPa]")
legend("Constant Temperature", "Changing Temperature" )

% Create a strain vector based on strain rate and time
strain_rate = 0.04; % 1/second
constTemp_strain = strain_rate * constTemp_time;
changeTemp_strain = strain_rate * changeTemp_time;


% Plot stress over strain
figure
plot( constTemp_strain, constTemp_cauchy, 'kd');
hold on
plot( changeTemp_strain, changeTemp_cauchy, 'bd');
title("Axial Stress over Strain")
xlabel("Strain")
ylabel("Cauchy Stress, Axial Component [MPa]")
legend("Constant Temperature", "Changing Temperature" )
