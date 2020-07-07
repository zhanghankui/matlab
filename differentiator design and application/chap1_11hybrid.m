%非线性微分跟踪器
clear all;
close all;

T = 0.001;%sampling time
y_1 = 0;dy_1 = 0;
yv_1 = 0;
v_1 = 0;

for k=1:1:20000
    t = k*T;
    time(k) = t;
    
    v(k) = sin(t);
    dv(k) = (v(k)-v_1)/T;
    d(k) = 0.1*rands(1);%noise
    yv(k) = v(k)+d(k);
    
    M=1;
    R=20;a0=0.1;a1=0.015;b0=0.015;b1=0.015;m=3;n=5;q=m/n;
    if M==1 %ODE45 for TD
        k1 = T*dy_1;
        k2 = T*(dy_1+T/2);
        k3 = T*(dy_1+T/2);
        k4 = T*(dy_1+T);
        y(k) = y_1 + (k1+2*k2+2*k3+k4)/6;
        
        kk1 = T*R^2*(-a0*(y(k)-yv(k))-a1*(abs(y(k)-yv(k)))^q*sign(y(k)-yv(k))-b0*dy_1/R-b1*(abs(dy_1/R))^q*sign(dy_1));
        kk2 = T*R^2*(-a0*(y(k)-yv(k))-a1*(abs(y(k)-yv(k)))^q*sign(y(k)-yv(k))-b0*(dy_1+kk1/2)/R-b1*(abs((dy_1+kk1/2)/R))^q*sign(dy_1+kk1/2));        
        kk3 = T*R^2*(-a0*(y(k)-yv(k))-a1*(abs(y(k)-yv(k)))^q*sign(y(k)-yv(k))-b0*(dy_1+kk2/2)/R-b1*(abs((dy_1+kk2/2)/R))^q*sign(dy_1+kk2/2));          
        kk4 = T*R^2*(-a0*(y(k)-yv(k))-a1*(abs(y(k)-yv(k)))^q*sign(y(k)-yv(k))-b0*(dy_1+kk3)/R-b1*(abs((dy_1+kk3)/R))^q*sign(dy_1+kk3));              
        dy(k) = dy_1+(kk1+2*kk2+2*kk3+kk4)/6;%speed by differetiator
    elseif M == 2%by difference for TD
        y(k) = y_1+T*dy_1;
        dy(k) = dy_1+T*R^2*(-a0*(y(k)-yv(k))-a1*(abs(y(k)-yv(k)))^q*sign(y(k)-yv(k))-b0*dy_1/R-b1*(abs(dy_1/R))^q*sign(dy_1));
    end
    dyv(k) = (yv(k)-yv_1)/T;%speed by difference
    y_1 = y(k);
    yv_1 = yv(k);
    dy_1 = dy(k);
    v_1 = v(k);
    
end

figure(1);
subplot(211);
plot(time,v,'r',time,yv,'k','linewidth',2);
xlabel('time(s)');ylabel('v,yv');
legend('ideal signal','signal with noise');
subplot(212);
plot(time,v,'r',time,y,'k','linewidth',2);
xlabel('time(s)'),ylabel('v,y');
legend('ideal signal','signal by hybrid TD');

figure(2);
subplot(211);
plot(time,dv,'r',time,dyv,'k','linewidth',2);
xlabel('time(s)'),ylabel('dv,dyv');
legend('ideal derivative signal','derivative signal by difference');
subplot(212);
plot(time,dv,'r',time,dy,'k','linewidth',2);
xlabel('time(s)'),ylabel('dv,dy');
legend('ideal derivative signal','derivative signal by hybrid TD');

