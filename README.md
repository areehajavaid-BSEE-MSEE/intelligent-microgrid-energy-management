# Intelligent Energy Management System for a Renewable-Energy Microgrid

## Project Overview

This project implements a renewable-energy microgrid model using MATLAB and Simulink. It explores how solar generation, electrical demand, battery storage, and grid electricity can be coordinated through an energy management controller.

The model simulates microgrid operation over a 24-hour period and monitors power balance, battery charging and discharging, battery state of charge (SOC), and cumulative grid energy consumption.

## Objectives

* Model solar power generation and electricity demand.
* Analyze the power balance between generation and consumption.
* Implement a rule-based energy management controller.
* Simulate battery charging and discharging.
* Monitor battery SOC within specified operating limits.
* Calculate cumulative electricity imported from the grid.
* Explore opportunities to reduce grid dependence through improved energy management.

## System Configuration

| Parameter                               |    Value |
| --------------------------------------- | -------: |
| Simulation duration                     | 24 hours |
| Solar generation capacity               |     5 kW |
| Battery capacity                        |   10 kWh |
| Initial battery SOC                     |      50% |
| Minimum battery SOC                     |      20% |
| Maximum battery SOC                     |     100% |
| Maximum battery charging power          |     2 kW |
| Maximum battery discharging power       |     2 kW |
| Battery charging/discharging efficiency |      95% |
| Maximum grid import power               |    10 kW |

## Energy Management Strategy

The controller uses a rule-based approach to coordinate solar generation, electrical demand, battery storage, and grid electricity.

1. **Solar surplus:** The battery charges when solar generation exceeds the electrical load, subject to the charging power limit and battery SOC limit.
2. **Solar deficit:** The battery discharges when solar generation cannot meet demand, provided its SOC is above the minimum limit.
3. **Grid support:** Grid electricity supplies any remaining power deficit that the battery cannot cover.
4. **Battery protection:** The controller enforces minimum and maximum SOC limits.

## Tools and Technologies

* MATLAB
* Simulink
* MATLAB Function block
* Time-series input signals
* Rule-based energy management
* Battery SOC monitoring
* Power and energy analysis

## Project Files

| File                             | Description                                                                            |
| -------------------------------- | -------------------------------------------------------------------------------------- |
| `microgrid_parameters.m`         | Defines the microgrid parameters.                                                      |
| `microgrid_profiles.m`           | Defines hourly solar generation and load profiles and prepares Simulink input signals. |
| `microgrid_power_balance.m`      | Calculates and plots the power balance.                                                |
| `microgrid_battery_simulation.m` | Simulates battery operation and SOC.                                                   |
| `compare_energy_strategies.m`    | Compares two energy management strategies.                                             |
| `Intelligent_Microgrid_EMS.slx`  | Simulink model of the microgrid and its energy management controller.                  |
| `results/`                       | Contains simulation graphs and model screenshots.                                      |

## Simulation Results

The model monitors the following outputs:

* Solar generation profile
* Electrical load demand
* Solar generation minus load demand
* Battery charging and discharging power
* Battery state of charge
* Grid import power
* Cumulative grid energy consumption

The current Simulink simulation displayed approximately **17.8 kWh of cumulative grid energy import** over the 24-hour period.

This value represents the current model output and should be interpreted in the context of the implemented controller, input profiles, and discrete-time integration settings.

### Solar Generation
![Solar Generation](results/Solar%20generation.PNG)


### Load Demand
![Load Demand](results/Load_demand.PNG)

### Battery State of Charge
![Battery SOC](results/Battery_SOC.PNG)

### Cumulative Grid Energy
![Cumulative Grid Energy](results/Cumulative_grid_energy.PNG)

## How to Run the Project

1. Download or clone this repository.
2. Open MATLAB and navigate to the project directory.
3. Run `microgrid_parameters.m`.
4. Run `microgrid_profiles.m` to prepare the solar and load input signals.
5. Open `Intelligent_Microgrid_EMS.slx`.
6. Run the Simulink simulation.
7. Open the Scope blocks to inspect the simulation outputs.

The scripts can also be run individually for their respective analyses. Run the required setup scripts first when a script depends on variables created by another script.

## Future Improvements

* Implement battery SOC feedback using a discrete-time controller.
* Improve battery charge and discharge coordination.
* Add battery degradation and operating cost models.
* Compare rule-based control with optimization-based energy management.
* Investigate machine learning approaches for renewable generation forecasting and energy scheduling.
* Evaluate grid energy consumption under different operating scenarios.

## Project Purpose

This project is part of my technical portfolio in renewable energy systems, intelligent energy management, and smart grids. It provides a foundation for further research into renewable-energy integration, battery storage coordination, and power system optimization.
