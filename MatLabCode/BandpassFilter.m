% Band-pass Filter

% This script implements and analyzes a band-pass filter

clc;clear;
%Input Signal - impulse
x = [1 ; 0 ; 0 ; 0 ; 0];
N = 5;

y = zeros(N,1);

x1 = 0; % sample with 1-sample of delay
x2 = 0; % 2-sample of delay

for n = 1:N
    
    y(n,1) = 0.5*(x(n,1) + -1*x2);
    x2 = x1;
    x1 = x(n,1);
    
   % if (n-2) < 1
    %    y(n,1) = 0.5 * x(n,1);
   % else
        % Two samples of Delay
    %    y(n,1) = 0.5 * (x(n,1) + -1*x(n-2,1));
    %end
end

h = [0.5, 0, -0.5];
freqz(h);

%Fs = 48000;
N = 1*Fs;
x = 0.2 * randn(N,1);

y = conv(x,h);

% or sound(y,Fs);
sound(x,Fs);