%非线性微分跟踪器
clear all;
close all;

h = 0.001;%sampling time
delta = 150;
r1_1 = 0;r2_1 = 0;
r_1 = 0;

for k = 1:1:3000
    time(k) = k*h;
    
    r0(k) = sin(2*pi*k*h);
    n(k) = 0.05*rands(1);%noise
    r(k) = r0(k)+n(k);
    dr0(k) = 2*pi*cos(2*pi*k*h);
    
    r1(k) = r1_1+h*r2_1;%跟踪器计算r1
    r2(k) = r2_1+h*hfan((r1_1-r(k)),r2_1,delta,h);
    
    r1_1 = r1(k);
    r2_1 = r2(k);
    
    if(k>100)
        dr(k) = (r(k)-r(k-100))/h/100;
    else
        dr(k) = 0;
        %dr(k) = (r(k)-r_1)/h;%直接差分
    end
    r_1 = r(k);
end

figure(1);
subplot(211);
plot(time,r0,'r',time,r,'k','linewidth',2);
xlabel('time(s)');ylabel('r0,r');
legend('ideal signal','signal with noise');
subplot(212);
plot(time,r0,'r',time,r1,'k','linewidth',2);
xlabel('time(s)'),ylabel('r0,r1');
legend('ideal signal','signal by TD');

figure(2);
subplot(211);
plot(time,dr0,'r',time,dr,'k','linewidth',2);
xlabel('time(s)'),ylabel('dr0,dr');
legend('ideal derivative signal','derivative signal by difference');
subplot(212);
plot(time,dr0,'r',time,r2,'k','linewidth',2);
xlabel('time(s)'),ylabel('dr0,r2');
legend('ideal derivative signal','derivative signal by TD');

