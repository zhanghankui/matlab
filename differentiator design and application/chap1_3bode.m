close all;
g= tf([1],[0.02 1]);
bode(g,'k');
grid on;