close all;

figure(1);
subplot(211);
plot(t,sin(t),'k:',t,r(:,1),'k','linewidth',2);
xlabel('time(s)');ylabel('signal');
legend('ideal signal','signal with noise');

subplot(212);
plot(t,sin(t),'k:',t,y(:,1),'k','linewidth',2);
xlabel('time(s)');ylabel('signal tracking');
legend('ideal signal','x1 by high-gain differentiator');

figure(2);
subplot(211);
plot(t,cos(t),'r',t,r(:,2),'k','linewidth',2);
xlabel('time(s)');ylabel('derivative signal');
legend('ideal derivative signal','derivative output by matlab');
subplot(212);
plot(t,cos(t),'k:',t,y(:,2),'k','linewidth',2);
xlabel('time(s)');ylabel('derivative signal');
legend('ideal derivative signal','x2 by high-gain differentiator');