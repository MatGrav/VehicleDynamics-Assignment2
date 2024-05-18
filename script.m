clear all; close all; clc

%% Parameters initialization
run('Pacejka for Homework\Load_Tyre_Data.m')
load('vehicle_parameters.mat')

velstart = 0;
% Note: as of today (May 15th), simulation starts slowly at 0 init speed

wheel_radius = 0.359; % m

g = 9.81; % m/s^2 

rho = 1.204; % air density [kg/m3] at 20°C
%%

inclination = 0;



%s0 = -1;
%s_slope = 0.2;


Tsim = 200;

%%
%open("model.slx");

%% Longitudinal acceleration test in high-tyre road friction conditions
velstart = 0;
mu_slope = 0;
mu0 = 1;

% target = 200/3.6;
% 
% s = sim("model.slx");
% 
% plot(s.tout(:),3.6*s.v_x(:))
% grid on
% xlabel("time [s]")
% ylabel("speed [km/h]")
% 
% % Km/h
% init_speeds = [0 0 40 80];
% final_speeds = [50 100 70 120];
% 
% for i = 1:length(init_speeds)
% 
%     % The target value we want to check for (replace with your desired value)
%     target_value = 100;
% 
%     % Find the index where s.v_x starts from 0
%     start_index = find(3.6*s.v_x <= init_speeds(i), 1, 'last');
% 
%     % Find the index where s.v_x reaches the target value
%     end_index = find(3.6*s.v_x >= final_speeds(i), 1, 'first');
% 
%     % Calculate the time it took to reach the target value
%     if isempty(start_index) || isempty(end_index)
%         error('Start or end index not found in the arrays.');
%     end
% 
%     % Ensure start_index is before end_index
%     if start_index < end_index
%         time_to_reach_value = s.tout(end_index) - s.tout(start_index);
%         fprintf('Time to reach %d from %d is %f seconds.\n', final_speeds(i), init_speeds(i), time_to_reach_value);
%     else
%         error('Start index is not before the end index.');
%     end
% 
% end   

%
init_speeds = [0 0 40 80];
final_speeds = [50 100 70 120];

for i = 1:length(init_speeds)

    velstart = init_speeds(i)/3.6;
    target = final_speeds(i)/3.6;

    s = sim("model.slx");
    
    fprintf('Time to reach %.2f from %.2f is %f seconds.\n', 3.6*target, 3.6*velstart, s.tout(end));
    %plot(s.tout(:),3.6*s.v_x(:))
    fprintf('Rolling res loss of %.2f [Wh].\n\n', s.P_rr(end));
        
end   

