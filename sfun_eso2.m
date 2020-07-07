function [sys,x0,str,ts] = sfun_eso2(t,x,u,flag,k1,k2,k3)
switch flag,
    case 0 %初始化
        [sys,x0,str,ts] = mdlInitializeSizes;
    case 1 %连续状态更新
        sys = mdlDerivatives(t,x,u,k1,k2,k3);
    case 3 %输出量的计算
        sys = mdlOutputs(t,x,u);
    case {2,4,9} %未使用的flag值
        sys = [];
    otherwise %处理错误
        error(['Unhandled flag = ',num2str(flag)]);
end

%=======================================================
%当flag为0时进行整个系统的初始化
%=======================================================

function [sys,x0,str,ts] = mdlInitializeSizes
sizes = simsizes; %读入初始化参数模板
sizes.NumContStates = 3 %连续状态
sizes.NumDiscStates = 0; %离散状态
sizes.NumOutputs = 3 %输出向量
sizes.NumInputs = 2; %系统输入信号u,y
sizes.DirFeedthrough = 0; %输入不直接传到输出口
sizes.NumSampleTimes = 1; %单个采样时间

sys = simsizes(sizes); %设定系统初始化参数

x0 = [0 0 0]; %初始状态为零状态
str = [];
ts = [0 0]; %采样周期

%=====================================================
% 当flag为1时，进行连续系统的状态更新
%=====================================================

function sys = mdlDerivatives(t,x,u,k1,k2,k3);
e = x(1)-u(1);
sys(1) = x(2)-k1*fal(e,0.7,0.01);
sys(2) = x(3)-k2*fal(e,0.1,0.01)+u(2);
sys(3) = k3*fal(e,0.1,0.01);

%================================================
% 当flag为3时计算系统的输出变量：返回两个状态
%================================================

function sys = mdlOutputs(t,x,u);
sys = x;




