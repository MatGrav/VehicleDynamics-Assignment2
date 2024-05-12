clear all; clc; clear;

%% Powertrain
e_machine_peak_power = 150*10^3; % Watt
e_machine_max_torque = 310; % Nm
e_machine_max_speed = 16000; % rpm
gear_ratio = 10.5;
e_powertrain_pure_time_delay = 20; %ms
e_machine_torque_time_constant = 50; %ms

e_motor_inverter_efficiency = 0.90;
transmission_efficiency = 0.95;

torsional_stiffness = 9000; % Nm/rad
battery_capacity = 58; % kWh
battery_voltage = 800; % V

%% Tires

% Tyre rolling resistance coefficients
f0 = 0.009;
% f1 = 0
f2 = 6.5 * 10^-6; % s^2 / m^2

L_rel = 0.285; % Tyre relax. length (range between 0.12m and 0.45)

%% Friction brakes
brakes_generation_deadtime = 20; %ms
brakes_friction_rise_time = 25; %ms
brakes_torque_distribution = 3.0; % 75:25

%% Weight and aero
kerb_weight = 1812; % kg
wheelbase = 2.77; % m
CoG_height = 0.55; % m

FtoR_mass_distribution = 1; % 50:50
S = 2.36; % m^2 % cross section / frontal area
Cx = 0.27; % aerodinamic drag coefficient

%% Assumed parameters (vehicle-wise)

% Wheel mass moment of inertia [kg m^2], assumed from similar tires
Jns = 0.8;



save vehicle_parameters.mat