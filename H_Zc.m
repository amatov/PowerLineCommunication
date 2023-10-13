







figure(1);
[a]=textread('home/matov/matlab/H_FR.txt','%f');
[b]=textread('home/matov/matlab/Zc_MOD.txt','%f');
subplot(2,1,1),plot(a,b);
%xlabel('f, MHz');
ylabel('Module, Zc(f)');
title('Characteristic Impedance');
%legend('Measurement', 'Model');

set(gcf, 'DefaultTextFontSize', 16);
set(gca, 'FontSize', 16) ;
%figure(2);

[c]=textread('home/matov/matlab/Zc_PHA.txt','%f');
subplot(2,1,2),plot(a,c);
xlabel('f, MHz');
ylabel('Phase, Zc(f)');
%title('Characteristic Impedance');


set(gcf, 'DefaultTextFontSize', 16);
set(gca, 'FontSize', 16) ;
figure(3);

[e]=textread('home/matov/matlab/H_MOD.txt','%f');
subplot(2,1,1),plot(a,e);
%xlabel('f, MHz');
ylabel('Module, H(f)');
title('Frequency Response');
%legend('Measurement', 'Model');

set(gcf, 'DefaultTextFontSize', 16);
set(gca, 'FontSize', 16) ;

%figure(4);

[f]=textread('home/matov/matlab/H_PHA.txt','%f');
subplot(2,1,2),plot(a,f);
xlabel('f, MHz');
ylabel('Phase, H(f)');
%title('Frequency Response');
set(gcf, 'DefaultTextFontSize', 16);
set(gca, 'FontSize', 16) ;
%figure(5);
%[g]=textread('home/matov/matlab/P(E)_X.txt','%f');
%[h]=textread('home/matov/matlab/P(E)_Y.txt','%f');
%plot(g,h);
%xlabel('S/N, dB');
%ylabel('log P(E)');
%title('Error probability');