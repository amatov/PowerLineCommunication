
figure(1);
[a]=textread('home/matov/matlab/Pe_X2.txt','%f');
[b]=textread('home/matov/matlab/Pe_Y2.txt','%f');
plot(a(16:20),b(16:20));
xlabel('S/N, dB');
ylabel('log P(E)');
title('Error probability');

set(gcf, 'DefaultTextFontSize', 16);
set(gca, 'FontSize', 16) ;
