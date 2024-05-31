clear all; close all; clc

% Conversion shortcuts
J_to_Wh = 0.000277778;
Wh_to_J = 3600;
ms_to_kmh = 3.6;
kmh_to_ms = 1/ms_to_kmh;
rpm_to_rads = 0.10472;
rads_to_rpm = 1/rpm_to_rads;
m_to_km = 10^-3;

% Parameters initialization
run('Pacejka for Homework\Load_Tyre_Data.m')
run('parameters.m')

wheel_radius = 0.359; % m
g = 9.81; % m/s^2 

rho = 1.204; % air density [kg/m3] at 20°C

inclination = 0;
tau = torque_time_constant/3;
tau_brake = brakes_friction_rise_time/3;

initial_SoC = 1;
Tsim = 200;
BrakePedalPosition = 0;

curState = Tests.motor_on;

target = 400;
Vref = 400;
mu0 = 1;

%% Attempt at effective rolling radius computation
% cruise_control = true;
% velstart = 14;
% mu0 = 0.8;
% Vref = 4;
% 
% sim("model.slx");

%% Max speed test

curState = Tests.motor_on;

mu0 = 1;
Vref = 400;

velstart = 20;

Tsim = 200;
target = 300;
sim("model.slx");

top_speed = 3.6*max(v_x(:));
fprintf('Max speed: %.2f [Km/h].\n\n', top_speed);



%% Longitudinal acceleration test in high-tyre road friction conditions

curState = Tests.motor_on;

velstart = 0;
mu0 = 1;

Tsim = 30;

init_speeds = [0 0 40 80 0]; %km/h
final_speeds = [50 100 70 120 top_speed]; %km/h

for i = 1:length(init_speeds)

    velstart = init_speeds(i)/3.6;
    target = final_speeds(i)/3.6;

    sim("model.slx");
    
    fprintf('Time to reach %.2f from %.2f is %f seconds.\n', 3.6*target, 3.6*velstart, tout(end));
    fprintf('- Rolling res loss of %.2f [Wh].\n', E_rolling_res_Wh(end));
    fprintf('- Aero drag loss of %.2f [Wh].\n', E_aero_drag_Wh(end));
    fprintf('- Electric powertrain loss of %.2f [Wh].\n', E_powertrain_loss_Wh(end));
    fprintf('- Transmission loss of %.2f [Wh].\n', E_transmission_loss_Wh(end));
    fprintf('- Longitudinal tyre slip loss of %.2f [Wh].\n', E_long_slip_loss_Wh(end));
    fprintf('- Energy consumption  of %.2f [Wh].\n\n',E_consumption(end));

    
    % Graph
    name_fig = sprintf('[%.2f - %.2f]', ms_to_kmh*velstart, ms_to_kmh*target);
    fig = figure('Name',name_fig);
    hold on, grid on
    set(gca,'FontName','Times New Roman','FontSize',12)
    xlabel('t');
    plot(tout, a_x)
    plot(tout, v_x)
    legend('acceleration [m/s^2]', 'speed [m/s]', 'Location', 'best')

    output_dir = "Results";
    filename = sprintf('%s\\figure_%.2f_to_%.2f.png', output_dir, 3.6*velstart, 3.6*target);
    saveas(fig, filename);

end   


%% Cruise control test
curState = combineStates(Tests.motor_on,Tests.cruise_control);

velstart = 0*kmh_to_ms;
reference_speeds = [15 30 50 70 80 110 130 top_speed];
%reference_speeds = [15 140 top_speed];
Target = 600;
Tsim = 48*60*60;

for i = 1:length(reference_speeds)
%for i = 5:length(reference_speeds)
%for i = 5:5
    Vref = reference_speeds(i)*kmh_to_ms;
    sim("model.slx");

    % IMPORTANT: check why top_speed is not actually reached in the
    % simulation
    fprintf('Driven km: %.2f [km] at speed of %.2f [km/h].\n\n', m_to_km*X,ms_to_kmh*max(v_x(:)));
end

%% Tip-in test
curState = combineStates(Tests.motor_on,Tests.tip_in,Tests.tyre_relaxation_disabled);

velstart = 3;
Tsim = 9;

sim("model.slx");

name_fig = sprintf('Tip-in test');
fig = figure('Name',name_fig);
hold on, grid on
set(gca,'FontName','Times New Roman','FontSize',12)
xlabel('t');
plot(tout, a_x)
legend('acceleration [m/s^2]', 'Location', 'best')

%% Acceleration-Braking tests with regenerative braking

% primissimo test in cui parto da una certa velocità e freno e basta
in_speed = kmh_to_ms*[30 20];
Tsim = 90;
s = [combineStates(Tests.motor_on,Tests.regen_braking,Tests.tyre_relaxation_disabled) combineStates(Tests.motor_on,Tests.regen_braking_with_acceleration)];

for i = 1:length(in_speed)
    curState = s(i);
    velstart = in_speed(i);
    initial_SoC = 0.5;

    sim("model.slx")
    fprintf('\n Test of regenerative braking \n');
    fprintf(' - Energy consumed of %.2f [Wh] \n', E_consumed);
    fprintf(' - Energy regenerated of %.2f [Wh] \n', E_regenerated);
    fprintf('Started at %.2f percent, ended test at %.2f percent \n', initial_SoC*100,final_SoC*100);
end

%%
curState = combineStates(Tests.motor_on,Tests.regen_braking_with_rep_acceleration,Tests.tyre_relaxation_disabled);

velstart = 0*kmh_to_ms;
Tsim = 20;
 
sim("model.slx")
fprintf('\n Test of repeated acceleration and deceleration with regen\n');
fprintf(' - Energy consumed of %.2f [Wh] \n', E_consumed);
fprintf(' - Energy regenerated of %.2f [Wh] \n', E_regenerated);
fprintf('Started at %.2f percent, ended test at %.2f percent \n', initial_SoC*100,final_SoC*100);


%% Emergency braking tests

curState = combineStates(Tests.emergency_braking, Tests.tyre_relaxation_disabled);
Tsim = 30;

% Dry tarmac
mu0 = 1;
w_dot_critic = -70; % rad/s^2 %% ABS
velstart = 100*kmh_to_ms;
BrakePedalPosition = 1;

sim("model.slx");
fprintf('\nStopping distance of %.2f [m] starting from %.2f [km/h].\n', X,velstart*ms_to_kmh);

% Wet tarmac
% mu0 = 0.4;
% w_dot_critic = -70; % rad/s^2 %% ABS
% velstart = 100*kmh_to_ms;
% 
% sim("model.slx");
% fprintf('\nStopping distance of %.2f [m] starting from %.2f [km/h].\n\n', X,velstart*ms_to_kmh);

BrakePedalPosition = 0; % Current workaround to re-do correctly other tests after this
mu0 = 1;

%% User-defined function

function combinedState = combineStates(varargin)
    combinedState = uint32(0);
    for i = 1:nargin
        combinedState = bitor(combinedState, varargin{i});
    end
end