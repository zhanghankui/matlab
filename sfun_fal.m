function [sys,x0,str,ts] = fal(t,x,u,flag,a,det)
switch flag,
    %======================================================
    %��ʼ��
    %======================================================
    case 0,
        [sys,x0,str,ts] = mdlInitializeSizes;
    case 3 %������ļ���
        sys = mdlOutputs(t,x,u);
    case {1,2,4,9} %δʹ�õ�flagֵ
        sys = [];
    otherwise %�������
        error(['Unhandled flag = ',num2str(flag)]);
end

%=======================================================
%��flagΪ0ʱ��������ϵͳ�ĳ�ʼ��
%=======================================================

function [sys,x0,str,ts] = mdlInitializeSizes
sizes = simsizes; %�����ʼ������ģ��
sizes.NumContStates = 0 %����״̬
sizes.NumDiscStates = 0; %��ɢ״̬
sizes.NumOutputs = 1 %�������
sizes.NumInputs = 1; %ϵͳ�����ź�u,y
sizes.DirFeedthrough = 1; %
sizes.NumSampleTimes = 1; %��������ʱ��
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

