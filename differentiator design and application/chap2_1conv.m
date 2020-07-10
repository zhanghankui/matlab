function [sys,x0,str,ts] = s_function(t,x,u,flag)
switch flag,
    case 0,
        [sys,x0,str,ts] = mdlInitializeSizes;
    case 1,
        sys = mdlDerivatives(t,x,u);
    case 3,
        sys = mdlOutputs(t,x,u);
    case {2,4,9}
        sys = [];
    otherwise
        error(['Unhandled flag=',num2str(flag)]);
end

function [sys,x0,str,ts] = mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates = 3;
sizes.NumDiscStates = 0;
sizes.NumOutputs = 3;
sizes.NumInputs = 0;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0 = [2 2 2];
str = [];
ts=[0 0];
function sys = mdlDerivatives(t,x,u)
alfa = 0.5;
sys(1) = -2*(x(1))^3;% asympotically convergent dx = -2(x^3)
sys(2) = -2*x(2);    % exponentially convergent dx = -2x
sys(3) = -2*(abs(x(3)))^alfa*sign(x(3));% finite--time convergent
function sys = mdlOutputs(t,x,u)
sys(1) = x(1);
sys(2) = x(2);
sys(3) = x(3);

