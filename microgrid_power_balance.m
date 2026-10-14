
%% Step 4: Microgrid Power Balance Analysis
% Project: Intelligent Energy Management System
% Purpose: Calculate the solar power surplus and deficit

clear;
clc;
close all;

%% 1. Time Vector
time = 0:1:24;

%% 2. Solar PV Generation (kW)
solar_power = [ ...
    0 0 0 0 0 0.2 0.8 1.8 3.0 4.0 ...
    4.6 5.0 4.8 4.2 3.2 2.0 0.8 0.2 0 0 ...
    0 0 0 0 0];

%% 3. Building Electricity Demand (kW)
load_power = [ ...
    1.2 1.0 0.9 0.8 0.8 1.0 1.5 2.0 2.5 2.8 ...
    3.0 3.2 3.0 2.8 2.7 2.8 3.2 3.8 4.0 3.5 ...
    3.0 2.5 2.0 1.5 1.3];

%% 4. Calculate Power Balance
power_balance = solar_power - load_power;

%% 5. Identify Surplus and Deficit
surplus_power = max(power_balance, 0);
deficit_power = max(-power_balance, 0);

%% 6. Display Results
fprintf('Microgrid Power Balance Analysis\n');
fprintf('--------------------------------\n');

fprintf('Maximum solar generation: %.2f kW\n', max(solar_power));
fprintf('Maximum building demand: %.2f kW\n', max(load_power));

fprintf('Maximum power surplus: %.2f kW\n', max(surplus_power));
fprintf('Maximum power deficit: %.2f kW\n', max(deficit_power));

fprintf('Total surplus energy: %.2f kWh\n', sum(surplus_power));
fprintf('Total deficit energy: %.2f kWh\n', sum(deficit_power));

%% 7. Plot Power Balance
figure;

plot(time, power_balance, '-o', 'LineWidth', 1.8);

hold on;
yline(0, '--k', 'Zero Power Balance');

xlabel('Time (hours)');
ylabel('Solar Power - Load Demand (kW)');
title('Microgrid Power Surplus and Deficit');
grid on;
xlim([0 24]);

hold off;

%% 8. Plot Surplus and Deficit
figure;

plot(time, surplus_power, '-g', 'LineWidth', 1.8);

hold on;

plot(time, deficit_power, '-r', 'LineWidth', 1.8);

xlabel('Time (hours)');
ylabel('Power (kW)');
title('Solar Power Surplus and Deficit');
legend('Surplus Power', 'Deficit Power', 'Location', 'best');
grid on;
xlim([0 24]);

hold off;

fprintf('\nPower balance analysis completed successfully!\n');
