close all;
clear all;
fs=1000;N=42;   %����Ƶ�ʺ����ݵ���
n=0:N-1;
% t=n/fs;   %ʱ������
% x=0.5*sin(2*pi*15*t); %�ź�
x=[0 30 0 0 30 0 0 30 0 0 30 0 0 30 0 0 30 0 0 30 0 0 30 0 0 30 0 0 30 0 0 30 0 0 30 0 0 30 0 0 30 0];
y=fft(x);    %���źŽ��п���Fourier�任
mag=abs(y);     %���Fourier�任������
f=n*fs/N;    %Ƶ������
% subplot(2,2,1);
plot(f,mag);   %�����Ƶ�ʱ仯�����
xlabel('Ƶ��/Hz');
ylabel('���');title('N=128');grid on;

