clear all; close all; clc

%% Parameters initialization
run('Pacejka for Homework\Load_Tyre_Data.m')
load('vehicle_parameters.mat')

velstart = 0;
wheel_radius = 359; % mm

g = 9.81; % m/s^2 

rho = 1.204; % air density [kg/m3] at 20°C
%%

inclination = 0;

Tsim = 100;
open("model.slx");
