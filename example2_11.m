clc;
clear;

%CT parameters
R_2p = 9.6e-6;
X_2p = 54.3e-6;
X_m = 17.7e-3;

N_1 = 5;
N_2 = 800;
N = N_1/N_2;

%Load impedance
R_b = 2.5;
X_b = 0;
Z_bp = N^2*(R_b+j*X_b);

%Primary current
I1 = 800;

%Secondary current
I2 = I1*N*j*X_m/(Z_bp + R_2p + j*(X_2p + X_m));

magI2 = abs(I2);
phaseI2 = 180*angle(I2)/pi;

fprintf('\nSecondary current magnitude = %g [A]',magI2);
fprintf('\n and phase angle = %g [degrees]\n\n',phaseI2);