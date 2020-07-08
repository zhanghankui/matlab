close all;
clear all;
fs=1000;N=42;   %采样频率和数据点数
n=0:N-1;
% t=n/fs;   %时间序列
% x=0.5*sin(2*pi*15*t); %信号
x=[0 30 0 0 30 0 0 30 0 0 30 0 0 30 0 0 30 0 0 30 0 0 30 0 0 30 0 0 30 0 0 30 0 0 30 0 0 30 0 0 30 0];
y=fft(x);    %对信号进行快速Fourier变换
mag=abs(y);     %求得Fourier变换后的振幅
f=n*fs/N;    %频率序列
% subplot(2,2,1);
plot(f,mag);   %绘出随频率变化的振幅
xlabel('频率/Hz');
ylabel('振幅');title('N=128');grid on;

