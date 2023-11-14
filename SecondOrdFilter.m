classdef SecondOrdFilter < handle
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        A = zeros(2,2);
        B = zeros(2,1);
        
        % row 1: filtered value. row 2: filtered derivative value.
        Ystate = zeros(2,1);
    end

    methods
        function obj = SecondOrdFilter(Ts,Tf)
            % Initialize yf and yfd states
            obj.Ystate(1,1) = 0;
            obj.Ystate(2,1) = 0;

            % Help variables
            h1 = Ts/Tf;
            h2 = exp(-h1);
            h3 = h1 * h2;
            h4 = h3/Tf;

            % ZOH sampled filter state space matrix elements
            obj.A(1,1) = h2 + h3;
            obj.A(1,2) = h2 * Ts;
            obj.A(2,1) = -1*h4;
            obj.A(2,2) = h2 - h3;
            obj.B(1,1) = 1 - h2 - h3;
            obj.B(2,1) = h4;
        end

        function [yf, yfd] = filtrate(obj,y)
            % Filtering signal y. Returns filtered signal and filtered
            % signal derivative
            obj.Ystate = obj.A * obj.Ystate + obj.B * y;
            yf = obj.Ystate(1,1);
            yfd = obj.Ystate(2,1);
        end
    end
end