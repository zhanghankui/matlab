clc
clear

%PT parameters
R1 = 128;
X1 = 143;
Xm = 163e3;

N1 = 2400;
N2 = 120;
N = N1/N2;

%Priary voltage
V1 = 2400;

%Secondary voltage
V2 = V1*(N2/N1)*(j*Xm/(R1+j*(X1+Xm)));
magV2 = abs(V2);
phaseV2 = 180*angle(V2)/pi;

fprintf('\nMagnitude of V2 = %g [V]',magV2);
fprintf('\n and angle = %g [degrees]\n\n',phaseV2);




