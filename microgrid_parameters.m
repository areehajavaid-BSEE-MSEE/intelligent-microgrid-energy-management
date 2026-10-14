
%% Intelligent Energy Management System for a Renewable-Energy Microgrid
% Project 4: MATLAB/Simulink Microgrid Energy Management
% Purpose: Define the initial microgrid parameters

clear;
clc;
close all;

%% 1. Simulation Settings
simulation_time = 24;       % Simulation duration (hours)
time_step = 1;              % Time step (hours)
time = 0:time_step:simulation_time;

%% 2. Solar PV System
PV_rated_power = 5;         % Rated solar PV power (kW)

%% 3. Battery Energy Storage
battery_capacity = 10;      % Battery capacity (kWh)
initial_SOC = 50;           % Initial battery state of charge (%)
minimum_SOC = 20;           % Minimum allowable SOC (%)
maximum_SOC = 100;          % Maximum allowable SOC (%)

%% 4. Utility Grid
grid_import_limit = 10;     % Maximum grid import power (kW)

%% 5. Electrical Load
peak_load = 4;              % Peak building load (kW)

%% 6. Battery Operating Limits
maximum_charge_power = 2;   % Maximum charging power (kW)
maximum_discharge_power = 2;% Maximum discharging power (kW)

%% 7. Display Parameters
fprintf('Microgrid parameters loaded successfully!\n\n');

fprintf('Solar PV rated power: %.1f kW\n', PV_rated_power);
fprintf('Battery capacity: %.1f kWh\n', battery_capacity);
fprintf('Initial battery SOC: %.1f%%\n', initial_SOC);
fprintf('Peak electrical load: %.1f kW\n', peak_load);
fprintf('Grid import limit: %.1f kW\n', grid_import_limit);

