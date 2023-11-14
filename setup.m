%% SETUP
close all
clear all

% Sampling period
ts = 0.1;

% Filter setup with sample time 0.1 and time constant 0.1
InputFilter = SecondOrdFilter(ts, 1);

% Parameter setup. Scaling with ts
Kp = 0;
Ki = 0 / ts;
Kd = 0 * ts;

uMin = 0;
uMax = 1;
u0 = 0; 

% States and globals?
% Integral state
I = 0;
% Last Sample Time
tOld = datetime('now', 'Format', 'yyyy-MM-dd HH:mm:ss.SSSSSS');