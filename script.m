clear all; close all; clc

%% Shortcuts
J_to_Wh = 0.000277778;
Wh_to_J = 3600;
ms_to_kmh = 3.6;
kmh_to_ms = 1/ms_to_kmh;
rpm_to_rads = 0.10472;
rads_to_rpm = 1/rpm_to_rads;

%% Parameters initialization
run('Pacejka for Homework\Load_Tyre_Data.m')
run('parameters.m')
%load('vehicle_parameters.mat')

wheel_radius = 0.359; % m

g = 9.81; % m/s^2 

rho = 1.204; % air density [kg/m3] at 20°C

inclination = 0;

%s0 = -1;
%s_slope = 0.2;

Tsim = 200;

%% Longitudinal acceleration test in high-tyre road friction conditions
velstart = 0;
%mu_slope = 0;
mu0 = 1;

init_speeds = [0 0 40 80 0]; %km/h
final_speeds = [50 100 70 120 140]; %km/h

for i = 1:length(init_speeds)

    velstart = init_speeds(i)/3.6;
    target = final_speeds(i)/3.6;

    sim("model.slx");
    
    fprintf('Time to reach %.2f from %.2f is %f seconds.\n', 3.6*target, 3.6*velstart, tout(end));
    %plot(tout(:),3.6*v_x(:))
    fprintf('Rolling res loss of %.2f [Wh].\n', P_rr(end));
    fprintf('Aero drag loss of %.2f [Wh].\n', P_aero(end));
    fprintf('Electric powertrain loss of %.2f [Wh].\n', P_powertrain_loss(end));
    fprintf('Transmission loss of %.2f [Wh].\n', P_transmission_loss(end));
    fprintf('Longitudinal tyre slip loss of %.2f [Wh].\n\n', P_x(end));

    
    %% Graph
    % name_fig = sprintf('[%.2f - %.2f]', 3.6*velstart, 3.6*target);
    % fig = figure('Name',name_fig);
    % hold on, grid on
    % set(gca,'FontName','Times New Roman','FontSize',12)
    % xlabel('t');
    % plot(tout, a_x)
    % plot(tout, v_x)
    % legend('acceleration [m/s^2]', 'speed [m/s]', 'Location', 'best')
    % 
    % output_dir = "Results";
    % filename = sprintf('%s\\figure_%.2f_to_%.2f.png', output_dir, 3.6*velstart, 3.6*target);
    % saveas(fig, filename);

end   
%% max speed test??
velstart = 0;
%Tsim = 10000;
%target = 500;

Tsim = 300;
target = 300;
s = sim("model.slx");


fprintf('Max speed: %.2f [Km/h].\n\n', 3.6*max(v_x(:)));
