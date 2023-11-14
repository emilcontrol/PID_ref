function [dInew, Dnew, t] = SampleTiming(dI, D, ts, tOld)
    % Compensates for sampling time jitter
    %   Detailed explanation goes here
    t = datetime('now', 'Format', 'yyyy-MM-dd HH:mm:ss.SSSSSS');
    dt = seconds(t - tOld);
    if dt > 0
        dInew = dI * dt./ts;
        Dnew = D * ts./dt;
    else
        dInew = dI;
        Dnew = D;
    end
end