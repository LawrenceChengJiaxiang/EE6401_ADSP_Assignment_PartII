clear all
%% Computation for the first PSD function
Txx1 = []; % Assign matrix for the first PSD function
MAX = 1; % Maximum of f in PSD 
for f = 0 : 0.01 : MAX
    T = 2.195 * (abs((1-0.273*exp(-1i*2*pi*f))/(1-0.6*exp(-1i*2*pi*f))))^2;
    Txx1 = [Txx1, T];
end
%% Computation for the second PSD function
% Yule-Walker Method
A = [0.4171; 0.1654]\[0.5196,0.4171; 0.4171,0.5196]; 
var = 0.5196 + A(1,1)*0.4171 + A(1,2)*0.1654;
Txx2 = []; % Assign matrix for the second PSD function
for f = 0:0.01:MAX
    sum = 0;
    for k = 1:2
        sum = sum + A(1,k) * exp(-1i*2*pi*f*k);
    end
    T = var/(abs(1+sum))^2;
    Txx2 = [Txx2, T];
end
%% Plot both above PSD functions
subplot(2,1,1),plot(0:0.01:MAX, Txx1(1,1:length(Txx1)))
title('Power Spectrum Density Function \Gamma_{xx}(f)')
subplot(2,1,2),plot(0:0.01:MAX, Txx2(1,1:length(Txx2)))
title('Power Spectrum Density Function \Gamma_{vv}(f)')