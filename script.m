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

mu_slope = 0;
mu0 = 1;

%s0 = -1;
%s_slope = 0.2;


Tsim = 100;
open("model.slx");
