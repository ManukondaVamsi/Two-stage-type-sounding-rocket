#  Sounding Rocket – 2-Stage MATLAB Simulation

This project simulates the full flight of a **two-stage Astra-type sounding rocket** using MATLAB.  
The simulation models thrust, mass depletion, staging, drag, gravity losses, and altitude-dependent air density.  
It also generates visual plots for altitude, velocity, acceleration, and thrust throughout the mission.

## Project Overview

The script performs a time-step simulation of a 2-stage rocket using classical rocket dynamics:

- Variable mass due to propellant burn
- Stage separation logic
- Exponential atmospheric density model
- Aerodynamic drag using Cd, frontal area, and velocity
- Gravity losses
- Ideal thrust profiles for both stages
- Ground-impact termination
- Plotting full-flight performance and detailed stage-1/2 behavior

This tool is suitable for:
- Preliminary rocket design  
- Flight dynamics studies  
- Educational demonstrations  
- Aerospace engineering coursework  

## Features

Two-stage thrust and burn profiles  
Dynamic mass flow and staging logic  
Atmospheric density model (ρ = ρ₀ e^(−h/8500))  
Drag losses based on Cd and velocity direction  
Full flight plots:  
&nbsp;&nbsp;• Altitude  
&nbsp;&nbsp;• Velocity  
&nbsp;&nbsp;• Acceleration  
&nbsp;&nbsp;• Thrust  
Zoomed-in visualization until Stage-2 separation

##  Physics Models Used

### **1. Thrust & Mass Depletion**
\[
\dot{m} = \frac{T}{I_{sp} \cdot g}
\]

### **2. Atmospheric Density**
\[
\rho(h) = \rho_0 e^{-h/8500}
\]

### **3. Drag**
\[
D = \tfrac{1}{2}\rho v^2 C_d A
\]

### **4. Net Force**
\[
F_{net} = T - D - mg
\]

### **5. Equations of Motion**
\[
a = \frac{F_{net}}{m}, \qquad
v_{i+1} = v_i + a\Delta t, \qquad
h_{i+1} = h_i + v\Delta t
\]

## Output Plots

### **1. Full Flight Overview**
- Altitude vs Time  
- Velocity vs Time  
- Acceleration vs Time  
- Thrust vs Time  

### **2. Stage-Separation **
- Altitude (until Stage 2 ignition)  
- Velocity (until Stage 2 ignition)  
