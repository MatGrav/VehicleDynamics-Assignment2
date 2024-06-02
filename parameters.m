%% Powertrain
peak_power = 150*10^3; % Watt
max_torque = 310; % Nm
max_speed = 16000; % rpm
gear_ratio = 10.5;
powertrain_pure_time_delay = 0.020; % s
torque_time_constant = 0.050; % s

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

%% Weight and aero
kerb_weight = 1812; % kg
wheelbase = 2.77; % m
CoG_height = 0.55; % m

% 50:50 mass distribution
F_mass_ratio = 0.5;
R_mass_ratio = 1 - F_mass_ratio;

S = 2.36; % m^2 % cross section / frontal area
Cx = 0.27; % aerodinamic drag coefficient

%% Friction brakes
brakes_generation_deadtime = 0.020; % s
brakes_friction_rise_time = 0.025; % s
brakes_torque_distribution = 3.0; % 75:25

% Assumed parameters
brake_disc_radius = 0.33; % m
total_braking_force = kerb_weight*9.81;
braking_efficiency = 0.95;
%% Assumed parameters (vehicle-wise)

% Wheel mass moment of inertia [kg m^2], assumed from similar tires
Jns = 0.8;


%% Export

%save vehicle_parameters.mat