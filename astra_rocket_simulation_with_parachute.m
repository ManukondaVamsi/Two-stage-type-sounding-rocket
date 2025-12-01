% Astra Sounding Rocket 2-Stage Simulation – Enhanced with Ideal Plots
clear; clc;

% --- CONSTANTS ---
g = 9.81;                  % Gravity (m/s^2)
Cd = 0.24;                 % Drag coefficient (ascent)
D = 0.56;                  % Diameter (m)
A = pi * (D/2)^2;          % Cross-sectional area (m^2)
rho0 = 1.225;              % Sea-level air density (kg/m^3)

% --- STAGE PARAMETERS ---
% Stage 1
T1 = 195600; 
Isp1 = 197.64; 
burn1 = 3.4;
m1_prop = 634.373; 
m1_dry = 300;

% Stage 2
T2 = 76000;
Isp2 = 236.27;
burn2 = 19;
m2_prop = 1140;
m2_dry = 500;

% Payload
payload = 376;
m0 = m1_prop + m1_dry + m2_prop + m2_dry + payload;

% --- TIME SETTINGS ---
dt = 0.01;
t_total = 300;
time = 0:dt:t_total;
N = length(time);

% --- INITIALIZATION ---
alt = zeros(1,N);
vel = zeros(1,N);
acc = zeros(1,N);
mass = zeros(1,N);
thrust = zeros(1,N);

mass(1) = m0;
stage = 1;

m1_used = 0;
m2_used = 0;

for i = 2:N
    t = time(i);
    m = mass(i-1);
    v = vel(i-1);
    h = alt(i-1);

    % Dynamic air density with altitude
    rho = rho0 * exp(-h/8500);

    % Thrust & mass depletion
    if t <= burn1
        T = T1;
        mdot = T1 / (Isp1 * g);
        m1_used = min(m1_used + mdot * dt, m1_prop);
    elseif t <= burn1 + burn2
        if stage == 1
            m = m - m1_dry;  % Drop stage 1 dry mass
            stage = 2;
        end
        T = T2;
        mdot = T2 / (Isp2 * g);
        m2_used = min(m2_used + mdot * dt, m2_prop);
    else
        T = 0;
        mdot = 0;
    end

    % Total mass update
    m = m0 - m1_used - m2_used;
    if stage == 2
        m = m - m1_dry;
    end
    mass(i) = m;
    thrust(i) = T;

    % Drag force
    D = 0.5 * rho * v^2 * Cd * A * sign(v);

    % Net force and motion
    F_net = T - D - m * g;
    acc(i) = F_net / m;
    vel(i) = v + acc(i) * dt;
    alt(i) = h + vel(i) * dt;

    % Stop if it hits the ground
    if alt(i) <= 0
        alt(i:end) = 0;
        vel(i:end) = 0;
        acc(i:end) = 0;
        break;
    end
end

% --- PLOTS ---


figure('Name', 'Astra Rocket Simulation – Full Flight');
subplot(4,1,1)
plot(time, alt/1000, 'b')
ylabel('Altitude (km)')
title('Altitude vs Time')
grid on

subplot(4,1,2)
plot(time, vel, 'r')
ylabel('Velocity (m/s)')
title('Velocity vs Time')
grid on

subplot(4,1,3)
plot(time, acc, 'g')
ylabel('Acceleration (m/s²)')
title('Acceleration vs Time')
grid on

subplot(4,1,4)
plot(time, thrust/1000, 'k')
xlabel('Time (s)')
ylabel('Thrust (kN)')
title('Thrust vs Time')
grid on

% Plots Until Stage 2 Separation
idx_sep = find(time <= burn1 + burn2);

figure('Name', 'Zoomed-In: Until Stage 2 Separation');
subplot(2,1,1)
plot(time(idx_sep), alt(idx_sep)/100, 'b', 'LineWidth', 1.5)
xlabel('Time (s)')
ylabel('Altitude (km)')
title('Altitude vs Time (Stage 2 Sep)')
grid on

subplot(2,1,2)
plot(time(idx_sep), vel(idx_sep), 'r', 'LineWidth', 1.5)
xlabel('Time (s)')
ylabel('Velocity (m/s)')
title('Velocity vs Time (Stage 2 Sep)')
grid on