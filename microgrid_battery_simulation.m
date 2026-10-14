
%% Step 5: Battery Energy Storage Simulation
% Project: Intelligent Energy Management System
% Purpose: Simulate battery charging and discharging over 24 hours

clear;
clc;
close all;

%% 1. Time and Input Profiles
time = 0:1:24;
dt = 1;  % Time step in hours

solar_power = [ ...
    0 0 0 0 0 0.2 0.8 1.8 3.0 4.0 ...
    4.6 5.0 4.8 4.2 3.2 2.0 0.8 0.2 0 0 ...
    0 0 0 0 0];

load_power = [ ...
    1.2 1.0 0.9 0.8 0.8 1.0 1.5 2.0 2.5 2.8 ...
    3.0 3.2 3.0 2.8 2.7 2.8 3.2 3.8 4.0 3.5 ...
    3.0 2.5 2.0 1.5 1.3];

%% 2. Battery Parameters
battery_capacity = 10;      % kWh
initial_SOC = 50;           % %
minimum_SOC = 20;            % %
maximum_SOC = 100;           % %

maximum_charge_power = 2;    % kW
maximum_discharge_power = 2; % kW

charge_efficiency = 0.95;
discharge_efficiency = 0.95;

%% 3. Initialize Variables
N = length(time);

SOC = zeros(1, N);
battery_power = zeros(1, N);
grid_power = zeros(1, N);

SOC(1) = initial_SOC;

%% 4. Battery Energy Management
for k = 1:N-1

    % Positive balance means surplus solar power.
    power_balance = solar_power(k) - load_power(k);

    % Available battery energy and charging headroom.
    available_energy = max( ...
        (SOC(k) - minimum_SOC) / 100 * battery_capacity, 0);

    available_headroom = max( ...
        (maximum_SOC - SOC(k)) / 100 * battery_capacity, 0);

    if power_balance > 0

        % Charge the battery using surplus solar power.
        charge_power = min([ ...
            power_balance, ...
            maximum_charge_power, ...
            available_headroom / (charge_efficiency * dt)]);

        battery_power(k) = -charge_power;

        stored_energy = charge_power * charge_efficiency * dt;

        SOC(k+1) = SOC(k) + ...
            (stored_energy / battery_capacity) * 100;

    else

        % Discharge the battery to help meet the load.
        requested_power = min(-power_balance, maximum_discharge_power);

        discharge_power = min([ ...
            requested_power, ...
            available_energy * discharge_efficiency / dt]);

        battery_power(k) = discharge_power;

        removed_energy = discharge_power / discharge_efficiency * dt;

        SOC(k+1) = SOC(k) - ...
            (removed_energy / battery_capacity) * 100;

    end

    % Remaining power is imported from the utility grid.
    grid_power(k) = max( ...
        load_power(k) - solar_power(k) - battery_power(k), 0);

end

% Calculate grid power for the final time sample.
grid_power(N) = max( ...
    load_power(N) - solar_power(N) - battery_power(N), 0);

%% 5. Display Results
fprintf('Battery Simulation Completed Successfully!\n');
fprintf('-----------------------------------------\n');

fprintf('Initial battery SOC: %.2f%%\n', SOC(1));
fprintf('Final battery SOC: %.2f%%\n', SOC(N));
fprintf('Minimum simulated SOC: %.2f%%\n', min(SOC));
fprintf('Maximum simulated SOC: %.2f%%\n', max(SOC));
fprintf('Maximum grid import: %.2f kW\n', max(grid_power));

%% 6. Plot Battery SOC
figure;

plot(time, SOC, '-o', 'LineWidth', 1.8);

xlabel('Time (hours)');
ylabel('Battery SOC (%)');
title('Battery State of Charge Over 24 Hours');

grid on;
xlim([0 24]);
ylim([0 100]);

%% 7. Plot Battery Power
figure;

plot(time, battery_power, '-o', 'LineWidth', 1.8);

hold on;
yline(0, '--k');

xlabel('Time (hours)');
ylabel('Battery Power (kW)');
title('Battery Charging and Discharging');

legend('Battery Power', 'Zero Power', 'Location', 'best');
grid on;
xlim([0 24]);

hold off;

%% 8. Plot Grid Import
figure;

plot(time, grid_power, '-o', 'LineWidth', 1.8);

xlabel('Time (hours)');
ylabel('Grid Import Power (kW)');
title('Utility Grid Power Import');

grid on;
xlim([0 24]);

fprintf('\nAll three battery simulation plots generated.\n');
