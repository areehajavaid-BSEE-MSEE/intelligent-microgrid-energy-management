
%% Step 6: Comparison of Two Energy Management Strategies
% Strategy 1: Solar-First Battery Management
% Strategy 2: Reserve-Aware Battery Management

clear;
clc;
close all;

%% 1. Time and Input Profiles
time = 0:1:24;
dt = 1;

solar_power = [ ...
    0 0 0 0 0 0.2 0.8 1.8 3.0 4.0 ...
    4.6 5.0 4.8 4.2 3.2 2.0 0.8 0.2 0 0 ...
    0 0 0 0 0];

load_power = [ ...
    1.2 1.0 0.9 0.8 0.8 1.0 1.5 2.0 2.5 2.8 ...
    3.0 3.2 3.0 2.8 2.7 2.8 3.2 3.8 4.0 3.5 ...
    3.0 2.5 2.0 1.5 1.3];

%% 2. Battery Parameters
battery_capacity = 10;
initial_SOC = 50;
minimum_SOC = 20;
maximum_SOC = 100;

maximum_charge_power = 2;
maximum_discharge_power = 2;

charge_efficiency = 0.95;
discharge_efficiency = 0.95;

reserve_SOC = 40;

N = length(time);

%% 3. Initialize Strategy 1
SOC1 = zeros(1,N);
battery_power1 = zeros(1,N);
grid_power1 = zeros(1,N);

SOC1(1) = initial_SOC;

%% 4. Initialize Strategy 2
SOC2 = zeros(1,N);
battery_power2 = zeros(1,N);
grid_power2 = zeros(1,N);

SOC2(1) = initial_SOC;

%% 5. Simulate Both Strategies
for k = 1:N-1

    power_balance = solar_power(k) - load_power(k);

    %% Strategy 1: Solar-First Battery Management

    if power_balance > 0

        headroom1 = max( ...
            (maximum_SOC-SOC1(k))/100*battery_capacity,0);

        charge1 = min([ ...
            power_balance, ...
            maximum_charge_power, ...
            headroom1/(charge_efficiency*dt)]);

        battery_power1(k) = -charge1;

        SOC1(k+1) = SOC1(k) + ...
            charge1*charge_efficiency*dt/battery_capacity*100;

    else

        available1 = max( ...
            (SOC1(k)-minimum_SOC)/100*battery_capacity,0);

        discharge1 = min([ ...
            -power_balance, ...
            maximum_discharge_power, ...
            available1*discharge_efficiency/dt]);

        battery_power1(k) = discharge1;

        SOC1(k+1) = SOC1(k) - ...
            discharge1/discharge_efficiency*dt/battery_capacity*100;

    end

    grid_power1(k) = max( ...
        load_power(k)-solar_power(k)-battery_power1(k),0);

    %% Strategy 2: Reserve-Aware Battery Management

    if power_balance > 0

        headroom2 = max( ...
            (maximum_SOC-SOC2(k))/100*battery_capacity,0);

        charge2 = min([ ...
            power_balance, ...
            maximum_charge_power, ...
            headroom2/(charge_efficiency*dt)]);

        battery_power2(k) = -charge2;

        SOC2(k+1) = SOC2(k) + ...
            charge2*charge_efficiency*dt/battery_capacity*100;

    else

        available2 = max( ...
            (SOC2(k)-reserve_SOC)/100*battery_capacity,0);

        discharge2 = min([ ...
            -power_balance, ...
            maximum_discharge_power, ...
            available2*discharge_efficiency/dt]);

        battery_power2(k) = discharge2;

        SOC2(k+1) = SOC2(k) - ...
            discharge2/discharge_efficiency*dt/battery_capacity*100;

    end

    grid_power2(k) = max( ...
        load_power(k)-solar_power(k)-battery_power2(k),0);

end

%% 6. Final-Sample Grid Power
grid_power1(N) = max( ...
    load_power(N)-solar_power(N)-battery_power1(N),0);

grid_power2(N) = max( ...
    load_power(N)-solar_power(N)-battery_power2(N),0);

%% 7. Calculate Daily Grid Import
% Hourly samples are treated as one-hour intervals.
% The final endpoint is excluded from daily energy integration.

daily_grid_energy1 = sum(grid_power1(1:N-1))*dt;
daily_grid_energy2 = sum(grid_power2(1:N-1))*dt;

fprintf('ENERGY MANAGEMENT STRATEGY COMPARISON\n');
fprintf('-------------------------------------\n');

fprintf('Strategy 1 daily grid import: %.2f kWh\n', ...
    daily_grid_energy1);

fprintf('Strategy 2 daily grid import: %.2f kWh\n', ...
    daily_grid_energy2);

fprintf('Strategy 1 final SOC: %.2f%%\n',SOC1(N));
fprintf('Strategy 2 final SOC: %.2f%%\n',SOC2(N));

%% 8. Plot SOC Comparison
figure;

plot(time,SOC1,'-o','LineWidth',1.8);
hold on;
plot(time,SOC2,'-s','LineWidth',1.8);

yline(reserve_SOC,'--k','Reserve SOC');

xlabel('Time (hours)');
ylabel('Battery SOC (%)');
title('Comparison of Battery State of Charge');

legend('Strategy 1','Strategy 2','Reserve Threshold', ...
    'Location','best');

grid on;
xlim([0 24]);
ylim([0 100]);

hold off;

%% 9. Plot Grid Import Comparison
figure;

plot(time,grid_power1,'-o','LineWidth',1.8);
hold on;
plot(time,grid_power2,'-s','LineWidth',1.8);

xlabel('Time (hours)');
ylabel('Grid Import Power (kW)');
title('Comparison of Utility Grid Import');

legend('Strategy 1','Strategy 2','Location','best');

grid on;
xlim([0 24]);

hold off;

%% 10. Plot Daily Grid Import Energy
figure;

bar([daily_grid_energy1,daily_grid_energy2]);

set(gca,'XTickLabel',{'Strategy 1','Strategy 2'});

ylabel('Daily Grid Import (kWh)');
title('Daily Grid Energy Comparison');

grid on;

fprintf('\nStrategy comparison completed successfully!\n');
