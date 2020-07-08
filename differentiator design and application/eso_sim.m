%非线性微分跟踪器
clear all;
close all;

h = 0.1;%sampling time
delta = 8*h;
wo = 0.5;
beta01 = 3*wo;
beta02 = 3*wo*wo;
beta03 = wo^3;

%  beta01 = 2*wo;
%  beta02 = wo*wo;
r1_1 = 0;r2_1 = 0;r3_1 = 0;
r_1 = 0;

for k = 1:1:5000
    time(k) = k*h;
    
    r0(k) = fix(100*sin(2*pi*k*h*0.01));
    n(k) = fix(100*0.05*rands(1));%noise
    r(k) = r0(k)+n(k);
    dr0(k) = fix(100*2*pi*0.01*cos(2*pi*k*h*0.01));
 
    
    e = r1_1 - r(k);
    r1(k) = r1_1 + h*(r2_1-beta01*e);
%    r2(k) = r2_1 + h*(r3_1-beta02*fal(e,0.5,delta));
%    r3(k) = r3_1 - h*beta03*fal(e,0.25,delta);
    r2(k) = r2_1 + h*(r3_1-beta02*e);
   r3(k) = r3_1 - h*beta03*e;
   
   

    r1_1 = r1(k);
    r2_1 = r2(k);
    r3_1 = r3(k);
    
    if(k>100)
        dr(k) = (r(k)-r(k-10))/h/10;
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

