function [sys,x0,str,ts] = sfun_td(t,x,u,flag,r,T,h)
switch flag,
    case 0 %��ʼ��
        [sys,x0,str,ts] = mdlInitializeSizes;
    case 2 %��ɢ״̬����
        sys = mdlUpdates(t,x,u,r,T,h);
    case 3 %������ļ���
        sys = mdlOutputs(t,x);
    case {1,4,9} %δʹ�õ�flagֵ
        sys = [];
    otherwise %�������
        error(['Unhandled flag = ',num2str(flag)]);
end;
%=======================================================
%��flagΪ0ʱ��������ϵͳ�ĳ�ʼ��
%=======================================================

function [sys,x0,str,ts] = mdlInitializeSizes

sizes = simsizes; %�����ʼ������ģ��
sizes.NumContStates = 0; %������״̬
sizes.NumDiscStates = 2; %2����ɢ״̬
sizes.NumOutputs = 2 %��������������źź�΢���ź�
sizes.NumInputs = 1; %ϵͳ�����ź�1·
sizes.DirFeedthrough = 0; %���벻ֱ�Ӵ��������
sizes.NumSampleTimes = 1; %��������ʱ��

sys = simsizes(sizes); %�趨ϵͳ��ʼ������
x0 = [0 0]; %��ʼ״̬Ϊ��״̬
str = [];
ts = [-1 0]; %�������ڼ̳���һ����Ĭ��ֵ

%=====================================================
% ��flagΪ2ʱ��������ɢϵͳ��״̬����
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
% ��flagΪ3ʱ����ϵͳ�������������������״̬
%================================================
function sys = mdlOutputs(t,x)
sys = x;

