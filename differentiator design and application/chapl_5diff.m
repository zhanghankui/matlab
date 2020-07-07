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
vt=u(1);
e = x(1)-vt;
omegan = 30;%wn
zeta = 0.7;

sys(1) = x(2);
sys(2) = -omegan^2*e - 2*zeta*omegan*x(2);
function sys = mdlOutputs(t,x,u)
sys = x;