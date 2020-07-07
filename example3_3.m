clc;
clear;

% Here is the data: x in cm,L in mH
xdata = [0 0.2 0.4 0.6 0.8 1.0 1.2 1.4 1.6 1.8 2.0];
Ldata = [2.8 2.26 1.78 1.52 1.34 1.26 1.20 1.16 1.13 1.11 1.10];

%Convert to SI units
x = xdata*1.e-2;
L = Ldata*1.e-3;

len = length(x);
xmax = x(len);

% Use polyfit to perform a 4'th order fit of L to x, Store 
% the polynomial coefficients in vector a. The fit will be 
% of the form:
%
% Lfit = a(1)*x^4 + a(2)*x^3 + a(3)*x^2 + a(4)*x + a(5);
%
a = polyfit(x,L,4);
% Let's check the fit

for n = 1:101
    xfit(n) = xmax*(n-1)/100;
    Lfit(n) = a(1)*xfit(n)^4 + a(2)*xfit(n)^3 + a(3)*xfit(n)^2 ...
    + a(4)*xfit(n) + a(5);
end

% Plot the data and then the fit to compare (convert xfit to cm and
% Lfit to mH

plot(xdata,Ldata,'*');
hold
plot(xfit*100,Lfit*1000);
hold
xlabel('x [cm]');
ylabel('L [mH]');

fprintf('\n Paused. Hit and key to plot the force.\n');
pause;

% Now plot the force. The force will be given by 
%
%     i^2    dL    i^2
% f = --- * ---- = --- (4*a(1)*x^3 + 3*a(2)*x^2 + 2*a(3)*x + a(4))
%      2     dx     2

%Set current to 0.75A
I = 0.75;
for n = 1:101
    xfit(n) = 0.2/100 + 0.016*(n-1)/100;
    F(n) = 4*a(1)*xfit(n)^3 + 3*a(2)*xfit(n)^2 + 2*a(3)*xfit(n) + a(4);
    F(n) = (I^2/2)*F(n);
end

plot(xfit*100,F);
xlabel('x [cm]');
ylabel('Force [N]');



    