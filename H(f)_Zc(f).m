
figure(1);
%plot(linspace(0,T,N),o0,'g');%input cable 0 rectangular
%[a,b,c,d]=textread('D:\MATLABa\50bignewY12.5_25_2.txt','%f %f %f %f');
[a]=textread('D:\MATLABa\Zc_FR.txt','%f');
[b]=textread('D:\MATLABa\Zc_MOD.txt','%f');
%plot(e,f);
plot(a,b,'r');
%hold on;
%plot(linspace(0,T,N),C0(1:N),'b');%input cable 0 rectangular
xlabel('Time [s]');
ylabel('Amplitude [V]');
title('Step Response at Input');
legend('Measurement', 'Model');
hold off;
set(gcf, 'DefaultTextFontSize', 16) ;
set(gca, 'FontSize', 16) ;
