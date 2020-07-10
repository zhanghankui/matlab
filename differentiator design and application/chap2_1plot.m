close all;
figure(1);
plot(t,y(:,1),'r',t,y(:,2),'k',t,y(:,3),'b','linewidth',2);
xlabel('time(s)');ylabel('comparison of convergences');
legend('asympotically convergent','exponentially convergent','finite--time convergent');