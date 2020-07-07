function [sys,x0,str,ts] = sfun_td(t,x,u,flag,r,T,h)
switch flag,
    case 0 %初始化
        [sys,x0,str,ts] = mdlInitializeSizes;
    case 2 %离散状态更新
        sys = mdlUpdates(t,x,u,r,T,h);
    case 3 %输出量的计算
        sys = mdlOutputs(t,x);
    case {1,4,9} %未使用的flag值
        sys = [];
    otherwise %处理错误
        error(['Unhandled flag = ',num2str(flag)]);
end;
%=======================================================
%当flag为0时进行整个系统的初始化
%=======================================================

function [sys,x0,str,ts] = mdlInitializeSizes

sizes = simsizes; %读入初始化参数模板
sizes.NumContStates = 0; %无连续状态
sizes.NumDiscStates = 2; %2个离散状态
sizes.NumOutputs = 2 %输出向量：跟踪信号和微分信号
sizes.NumInputs = 1; %系统输入信号1路
sizes.DirFeedthrough = 0; %输入不直接传到输出口
sizes.NumSampleTimes = 1; %单个采样时间

sys = simsizes(sizes); %设定系统初始化参数
x0 = [0 0]; %初始状态为零状态
str = [];
ts = [-1 0]; %采样周期继承上一级的默认值

%=====================================================
% 当flag为2时，更新离散系统的状态变量
%=====================================================

function sys = mdlUpdates(t,x,u,r,T,h)

e = x(1)-u;
d = r*h;
d0 = d*h;
z = e+h*x(2);
a0 = sqrt(h^2+8*abs(z)/r);
x(1) = x(1)+T*x(2);
if abs(z)<d0
    g = x(2)+z/h;
else
    g = x(2)-sign(z)*r*(h-a0)/2;
end
if abs(g)<d
    x(2) = x(2)-T*r*(g/d);
else
    x(2) = x(2)-T*r*sign(g);
end
sys = x;

%================================================
% 当flag为3时计算系统的输出变量：返回两个状态
%================================================
function sys = mdlOutputs(t,x)
sys = x;

