clear all
%% Find optimal filter parameters using LSM algorithm
% Initialization for the variables
w0 = 6 / pi; y0(1,2) = 0;
d(1,2) = 0; D = d(1,2); y(1,2) = 0;
e(1,2) = 0; E = e(1,2); x(2,1) = 0;
% Initialization for filter parameters
h = [1; 1]; H = h;
% Using LMS Algorithm
u = 0.00125;
N = 150000; % Iteration steps
w(1,2) = wgn(1,1,0.001)/3; % White noise generation
S = cos(2*pi*w0*0); % Initilize for the desired signal
for n = 1 : N
    w(1,1) = wgn(1,1,0.001)/3;
    y0(1,1) = 0.5 * w(1,1) - 0.5*w(1,2);
    d(1,1) = cos(2*pi*w0*n) + y0(1,1);
    x(1,1) = w(1,1); % Input signal = w[n]
    y(1,1) = h(1,1) * x(2,1) + h(2,1) * x(1,1);
    e(1,1) = d(1,1) - y(1,1);
    h = h + u * e * x; % New filter parameters computation
    H = [H, h];
    % Store the data for next generation
    x(2,1) = x(1,1); d(1,2) = d(1,1);
    y0(1,2) = y0(1,1); w(1,2) = w(1,1); y(1,2)= y(1,1);
    D = [D,d(1,1)]; % Primary signal d[n]
    E = [E,e(1,1)]; % Error e[n] = d[n] - y[n]
    S = [S,cos(2*pi*w0*n)]; % Desired signal
end
%% Plot all above graphs
subplot(5,1,1),plot(1:N+1,H(1,:)),xlim([0,N])
title('Evolution of the first filter parameter');
subplot(5,1,2),plot(1:N+1,H(2,:)),xlim([0,N])
title('Evolution of the second filter parameter');
subplot(5,1,3),plot(1:200-1,D(1,N-200+2:N)),xlim([1,200]),ylim([-1,1])
title('Primary signal d[n]');
subplot(5,1,4),plot(1:200-1,E(1,N-200+2:N)),xlim([1,200]),ylim([-1,1])
title('e[n] = d[n] - y[n]');
subplot(5,1,5),plot(1:200-1,S(1,N-200+2:N)),xlim([1,200]),ylim([-1,1])
title('Desired sine wave signal');