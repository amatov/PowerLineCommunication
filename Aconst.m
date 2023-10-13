function const(Zt1,Zt2)

%variable values
l1=22;
l2=18;
eps=2.4;
Zc1=50;
Zc2=50;

%constant values
c0=299792458;
N=500;

%reflexion factors of lines
reflex1=(Zc1-Zt1)/(Zc1+Zt1);
reflex2=(Zc2-Zt2)/(Zc2+Zt2);

%propagation velocity in lines
v=c0/eps;

%propagation times
t1=l1/v;
t2=l2/v;

%create timebasevector
time=linspace(0,0.000001,N);

%calculate 1.wave out
place=v.*time;

%calculate 1.reflexions in first line (unten)
place1=calculate(place,N,l1);

%calculate 1.reflexions in second line (oben)
place2=calculate(place,N,(l1+l2));

%calculate 2.refelxions in first line (reflex unten)
place3=calculate2(place,N,l1,l2,1);
place3a=calculate2(place,N,l1,l2,2);
place3b=calculate2(place,N,l1,l2,3);
place3c=calculate2(place,N,l1,l2,4);
place3d=calculate2(place,N,l1,l2,5);

%calculate 2.refelxions in second line (reflex oben)
[place4,place4Add]=calculate3(place,N,l1,l2,1);
place4a=calculate3(place,N,l1,l2,2);
place4b=calculate3(place,N,l1,l2,3);

%output
figure(1);
hold on;
plot(time,l1.*ones(size(place1)),'r');
plot(time,(l1+l2).*ones(size(place1)),'r');
plot(time,zeros(size(place1)),'r');
plot(time,place1);
plot(time,place2);

plot(time,place3);
plot(time,place3a);
plot(time,place3b);
plot(time,place3c);
plot(time,place3d);

plot(time,place4);
plot(time,place4Add);
plot(time,place4a);
plot(time,place4b);

xlabel('Time [s]');
ylabel('Place [m]');
title('Reflexions');
axis([0,0.000001,0,(l1+l2)]);
hold off;

%third axis calculate (Voltage)
voltage=ones(1,N);
for i=1:N
   voltage(i)=1;
end
figure(2);
plot(time,voltage);
