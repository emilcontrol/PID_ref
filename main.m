setup;

%% INPUTS

% Measurement signal input: y
y = 1;
% Reference signal: r
r = 1;
% Feed-forward control signal
uff = 0;

% Mode: AUTO (0)/MAN (1)
Mode = 0;
% Manual control signal
uMan = 0;
% Bumpless flag
bFlag = 0;

%% METHOD

% Filter measurement signal
[yf, yfd] = InputFilter.filtrate(y);

 
% Controller state (MAN, AUTO). No need to clamp since clampin is in
% actuator block. Manual signal enters as feed-forward?
if Mode
    return
end


% Setpoint weighting
b = 1;
r = r * b;


% Compute P, I, D
P = Kp * (r - y) + u0 + uff;
dI = Ki * (r - y);
D = -Kd * yfd;


% Compensate time-jittering
[dI, D, tOld] = SampleTiming(dI, D, ts, tOld);


% Bumpless flag
if bFlag
    I = u - P - D;
    bFlag = 0;
end

% Anti-windup for max/min.
dI = antiWindup(P + I + D, dI, uMin, uMax);

% Clamping and anti-windup for max derivative. Maybe add...


% Update I
I = I + dI;

% Set control signal
u = P + I + D;

% Clamping?





