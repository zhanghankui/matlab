function [sys,x0,str,ts] = sfun_eso2(t,x,u,flag,k1,k2,k3)
switch flag,
    case 0 %��ʼ��
        [sys,x0,str,ts] = mdlInitializeSizes;
    case 1 %����״̬����
        sys = mdlDerivatives(t,x,u,k1,k2,k3);
    case 3 %������ļ���
        sys = mdlOutputs(t,x,u);
    case {2,4,9} %δʹ�õ�flagֵ
        sys = [];
    otherwise %�������
        error(['Unhandled flag = ',num2str(flag)]);
end

%=======================================================
%��flagΪ0ʱ��������ϵͳ�ĳ�ʼ��
%=======================================================

function [sys,x0,str,ts] = mdlInitializeSizes
sizes = simsizes; %�����ʼ������ģ��
sizes.NumContStates = 3 %����״̬
sizes.NumDiscStates = 0; %��ɢ״̬
sizes.NumOutputs = 3 %�������
sizes.NumInputs = 2; %ϵͳ�����ź�u,y
sizes.DirFeedthrough = 0; %���벻ֱ�Ӵ��������
sizes.NumSampleTimes = 1; %��������ʱ��

sys = simsizes(sizes); %�趨ϵͳ��ʼ������

x0 = [0 0 0]; %��ʼ״̬Ϊ��״̬
str = [];
ts = [0 0]; %��������

%=====================================================
% ��flagΪ1ʱ����������ϵͳ��״̬����
%=====================================================

function sys = mdlDerivatives(t,x,u,k1,k2,k3);
e = x(1)-u(1);
sys(1) = x(2)-k1*fal(e,0.7,0.01);
sys(2) = x(3)-k2*fal(e,0.1,0.01)+u(2);
sys(3) = k3*fal(e,0.1,0.01);

%================================================
% ��flagΪ3ʱ����ϵͳ�������������������״̬
%================================================

function sys = mdlOutputs(t,x,u);
sys = x;




