function dInew = antiWindup(v, dI, uMin, uMax)
%   ANTI-WINDUP 
%   Only allows integrator state error to be integrated in the sight
%   direction. Also makes sure the integrator state reaches max/min value.
    if v + dI < uMin && dI < 0
        dInew = min(0, uMin - v);
    elseif v + dI > uMax && dI > 0
        dInew = max(0, uMax - v);
    else
        dInew = dI;
    end
end