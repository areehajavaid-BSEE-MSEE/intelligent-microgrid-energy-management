
%% Step 3: Solar Generation and Building Load Profiles
% Project: Intelligent Energy Management System for a Renewable-Energy Microgrid

clear;
clc;
close all;

%% 1. Define the Time Vector
time = 0:1:24;  % Time in hours

%% 2. Solar PV Generation Profile
% Illustrative solar generation profile for a 5 kW PV system

solar_power = [ ...
    0 0 0 0 0 0.2 0.8 1.8 3.0 4.0 ...
    4.6 5.0 4.8 4.2 3.2 2.0 0.8 0.2 0 0 ...
    0 0 0 0 0];

%% 3. Building Electricity Demand Profile
% Illustrative building load profile

load_power = [ ...
    1.2 1.0 0.9 0.8 0.8 1.0 1.5 2.0 2.5 2.8 ...
    3.0 3.2 3.0 2.8 2.7 2.8 3.2 3.8 4.0 3.5 ...
    3.0 2.5 2.0 1.5 1.3];

%% 4. Plot Solar Generation
figure;

plot(time, solar_power, '-o', 'LineWidth', 1.8);

xlabel('Time (hours)');
ylabel('Solar Power (kW)');
title('24-Hour Solar PV Generation Profile');
grid on;
xlim([0 24]);
ylim([0 5.5]);

%% 5. Plot Building Electricity Demand
figure;

plot(time, load_power, '-s', 'LineWidth', 1.8);

xlabel('Time (hours)');
ylabel('Load Power (kW)');
title('24-Hour Building Electricity Demand Profile');
grid on;
xlim([0 24]);
ylim([0 4.5]);

%% 6. Display Basic Results
fprintf('Solar and load profiles created successfully!\n');
fprintf('Maximum solar power: %.1f kW\n', max(solar_power));
fprintf('Maximum building load: %.1f kW\n', max(load_power));
fprintf('Number of hourly samples: %d\n', numel(time));


%% Prepare signals for Simulink
solar_data = timeseries(solar_power', time');
load_data = timeseries(load_power', time');

disp('Solar and load data are ready for Simulink.');


