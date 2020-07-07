%Levant Î¢·ÖÆ÷º¯Êý
function[sys,x0,str,ts] = Differentiator(t,x,u,flag)
switch flag,
    case 0,
        [sys,x0,str,ts] = mdlInitializeSizes;
    case 1,
        sys = mdlDerivatives(t,x,u);
    case 3,
        sys = mdlOutputs(t,x,u);
    case {2,4,9}
        sys=[];
    otherwise
        error(['Unhandled flag=',num2str(flag)]);
end
function[sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates = 2;
sizes.NumDiscStates = 0;
sizes.NumOutputs = 2;
sizes.NumInputs = 1;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0 = [0 0];
str = [];
ts=[0 0];
function sys = mdlDerivatives(t,x,u)
%k1=1,k2=2;alfa=0.15
vt=u(1);
e = x(1)-vt;

R = 25;a0 = 0.1;a1 = 0.015;b0=0.3;b1=0.015;m=1;n=2;
q=m/n;

sys(1) = x(2);
sys(2) = -R^2*(a0*e+a1*(abs(e))^q*sign(e)+b0*x(2)/R+b1*(abs(x(2)/R))^q*sign(x(2)));

function sys = mdlOutputs(t,x,u)
sys = x;