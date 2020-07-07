function [sys,x0,str,ts] = fal(t,x,u,flag,a,det)
switch flag,
    %======================================================
    %初始化
    %======================================================
    case 0,
        [sys,x0,str,ts] = mdlInitializeSizes;
    case 3 %输出量的计算
        sys = mdlOutputs(t,x,u);
    case {1,2,4,9} %未使用的flag值
        sys = [];
    otherwise %处理错误
        error(['Unhandled flag = ',num2str(flag)]);
end

%=======================================================
%当flag为0时进行整个系统的初始化
%=======================================================

function [sys,x0,str,ts] = mdlInitializeSizes
sizes = simsizes; %读入初始化参数模板
sizes.NumContStates = 0 %连续状态
sizes.NumDiscStates = 0; %离散状态
sizes.NumOutputs = 1 %输出向量
sizes.NumInputs = 1; %系统输入信号u,y
sizes.DirFeedthrough = 1; %
sizes.NumSampleTimes = 1; %单个采样时间
sys = simsizes(sizes);

x0=[];
str=[];
ts = [0 0];
function sys = mdlOutputs(t,x,e,a,det)
if abs(e)>det
    sys = abs(e)^a*sign(e);
else
    sys = e/(det)^(1-a);
end

