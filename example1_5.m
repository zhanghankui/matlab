clc
clear
% Permeability of free space
mu0 = pi*4e-7;
% all dimensions expressed in meters
Ac = 9e-4; Ag = 9e-4; g= 5e-4; lc = 0.3;
N=500;
% Reluctance of air gap
Rg = g/(mu0*Ag);

for n = 1:101
    mur(n) = 100+(100000 - 100)*(n-1)/100;
    % Reluctance of core
    Rc(n) = lc/(mur(n)*mu0*Ac);
    Rtot = Rg+Rc(n);
    % Inductance
    L(n) = N^2/Rtot;
end

figure(1);
plot(mur,L);
xlabel('Core relative permeability');
ylabel('Inductance [H]');

mur = 70000;
Rc = lc/(mur*mu0*Ac);
for n = 1:10
    g(n) = 0.01*n;
    % Reluctance of gap
    Rg(n) = g(n)/(mu0*Ag);
    Rtot = Rg(n)+Rc;
    % Inductance
    LL(n) = N^2/Rtot;
end
figure(2);
plot(g,LL);
xlabel('gap');
ylabel('Inductance [H]');


