# VehicleDynamics-Assignment2

Homework made by:
s319634 Matteo Gravagnone,
s318083 Danilo Guglielmi

## Introduction

We are going to analyse the 
implementation and simulation of a rear-wheel-drive 
electric passenger car in MATLAB and Simulink. 

The target of the work is to develop a model of a vehicle 
motion and carry out simulations of different cases, 
related to the main elements involved in the 
longitudinal dynamics (acceleration, friction braking, 
energy consumption, regenerative braking)


#### Model layout (short description + manoeuvre parameters):
- model of longitudinal motion
- 4 wheels
    - Referenced model wheel_model.slx
    - Take as inputs Fz, friction coefficient, velocity of the vehicle, motor torque and braking (dissipative brakes) torque
    - Function that computes, by applying the Pacejka tyre model, the forces. Only the longitudinal force Fx is used in our work.
    - Wheel dynamics block applies the moment balance equation and computes the angular speed. 
    Negative contribution given from braking torque, rolling resistance torque and tractive torque? (Fx * R).
    - Power loss due to rolling resistance is computed
    - Subsystem models tyre relaxation expressed as a first order dynamics with a mass-damper similarity.
    - Function computes ideal slip, the actual slip given to the Pacejka model can either be the ideal one or the delayed one due to tyre relaxation
    - See: ABS implementation
- Longitudinal dynamics based on force balance equation
    - Aerodynamic, gravity (due to possible inclination, always set to 0 in the coursework) and rolling forces opposed to the sum of longitudinal tyre forces
- Subsystem takes multiple power losses and integrates them to obtain the energy loss due to rolling resistance, aerodynamic drag and so on
- Vertical load distribution with load transfer, with contributions due to aero drag and non-zero acceleration.
    - Does not take into account the rolling resistance parameter Dx which shifts the application point of Fzr and Fzf as it was considered negligible in prior simulations.
    - No downforce contributions
- Electric machine which outputs torque and power consumption
    - Computation of motor speed as a function to vehicle speed
    - Function that computes maximum available torque that can be produced at a given motor speed. This function then handles output torque based on curState variable which varies for given tests, so that output can be null, negative for regenerative braking and so on
    - First order transfer function for the output torque -> non ideality
    - Potential consideration of the time delay, so far not used
- Battery
    - Modeling of current energy available in terms of Wh, we decided not to go to Voltage and Current level
    - Also able to manage positive energy obtained in regenerative braking
    - Computes SoC
- Braking system
    - Currently computes force->torque at the front wheel under the physical threshold given from Fzf and mu.
    - Fixed brake distribution for the dissipative brakes
- Efficiencies
    - Trasmission efficiency factors and gear ratio for "motor" torque at wheel level
    - Inverter efficiency is correctly considered in positive and negative power contributions (not possible to get more kW at battery than the kW regenerated at wheel)
