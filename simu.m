function simu(N)

%HowTo
%-----
%We consider here 3 cables: At the end of the first the both(l0), the second (l1) and the third (l2)are connected simultainusely.
%Maindatainputs: 	Zc0 = caracteristic impedance of startcable (l0)
%						Zc1 = caracteristic impedance of long cable (l1)
%						Zc2 = caracteristic impedance of short cable(l2)
%						l0  = lenght in meters of startcable (l0)
%						l1  = lenght in meters of long cable (l1)
%						l2  = lenght in meters of short cable(l3)
%						Zt1 = termination impedance of long cable (l1)
%						Zt1 = termination impedance of short cable(l2)
%						
Zc0=27;
Zc1=27;
Zc2=45;
Zt0=50;%start/generator inpedance
Zt1=12.5;
Zt2=25;
l0=10;
l1=10;
l2=30;

c=0.005e-6; %cable constant, assumed 0.3

T=1e-6; % micros, total time for the simulation
t1=0.125e-6; %width of the rectangular impulse
dT=T/N;
nt1=round(t1/dT);
t=linspace(0,T,N);
%constant values
%c0=299792458;   

%reflection factors of lines
%start=1-(generatorvoltage/((startimp/Zc0)+1));
k=Zc0/(Zc0+Zt0);
refl0=-(Zc0-Zt0)/(Zc0+Zt0);%start/entry impedance reflection
refl1=-(Zc1-Zt1)/(Zc1+Zt1);%termination long cable
refl2=-(Zc2-Zt2)/(Zc2+Zt2);%termination short cable
ramrefl0=-(Zc0-(Zc1*Zc2/(Zc1+Zc2)))/(Zc0+(Zc1*Zc2/(Zc1+Zc2)));%reflectioncoefficient from startcable back to startcable
ramrefl1=-(Zc1-(Zc0*Zc2/(Zc0+Zc2)))/(Zc1+(Zc0*Zc2/(Zc0+Zc2)));%reflectioncoefficient from long cable back to long cable
ramrefl2=-(Zc2-(Zc1*Zc0/(Zc1+Zc0)))/(Zc2+(Zc1*Zc0/(Zc1+Zc0)));%reflectioncoefficient from short cable back to short cable

c0=299792458; %300000000; % m/s
eps=1.5; %given by manufacurer between 2 and 2.5 (square of the average 2.25 is 1.5)
v=c0/eps; %propagation velocity in lines
dl=v*dT;  %the distnace at which the signal propagates for time dT 

O0=zeros([N 1]); O1=zeros([N 1]); O2=zeros([N 1]); O3=zeros([N 1]); % the input, the junction, and the two outputs

N0=round(l0/dl); N1=round(l1/dl); N2=round(l2/dl); % the number of slices for each cabel
f0=zeros([N0 1]); b0=zeros([N0 1]); % buffer for propagation for each cable (forward&backward)
f1=zeros([N1 1]); b1=zeros([N1 1]);
f2=zeros([N2 1]); b2=zeros([N2 1]);

input=1:N; 

o0=1:N; om=1:N; o1=1:N; o2=1:N;
for i=1:N
   input(i)=1; %amplitude of the input signal
   if i*dT>t1
      input(i)=0; %input(i-1)-1;
   end
   %if input(i)<0
   %   input(i)=0;
   %end
   i0=mod(i,N0)+1; i1=mod(i,N1)+1; i2=mod(i,N2)+1; 
   j0=mod(i+1,N0)+1; j1=mod(i+1,N1)+1; j2=mod(i+1,N2)+1; 
   
   f0(i0)=k*input(i)+refl0*b0(j0);
   b0(i0)=ramrefl0*f0(j0)+(1-ramrefl1)*Zc2/(Zc2+Zc1)*b1(j1)+(1-ramrefl2)*Zc1/(Zc2+Zc1)*b2(j2);
   
   f1(i1)=ramrefl1*b1(j1)+(1-ramrefl0)*Zc2/(Zc2+Zc0)*f0(j0)+(1-ramrefl2)*Zc0/(Zc0+Zc2)*b2(j2);
   b1(i1)=refl1*f1(j1);
   
   f2(i2)=ramrefl2*b2(j2)+(1-ramrefl0)*Zc1/(Zc0+Zc1)*f0(j0)+(1-ramrefl1)*Zc0/(Zc0+Zc1)*b1(j1);
   b2(i2)=refl2*f2(j2);
   
   o0(i)=f0(i0)+b0(j0); 
   %om(i)=f0(j0)+b0(i0)+b1(j1)+b2(j2); 
   o1(i)=f1(j1)+b1(i1); 
   o2(i)=f2(j2)+b2(i2);
   %*********old***************************************
   %f0(i0)=k*input(i)+startrefl*b0(j0);
   %b0(i0)=ramrefl0*f0(j0) + b1(j1)+b2(j2);
   
   %f1(i1)=ramrefl1*f1(j1)+f0(j0)+b2(j2);
   %b1(i1)=refl1*f1(j1);
   
   %f2(i2)=ramrefl2*f2(j2)+f0(j0)+b1(j1);
   %b2(i2)=refl2*f2(j2);
   
   %o0(i)=f0(i0); om(i)=f0(j0)+b1(j1)+b2(j2); o1(i)=f1(j1); o2(i)=f2(j2);
   %************************************************************************
end

%*******************
%e=exp(-t/c);
A=1; %cable constant
B=1e-5;
for i=2:N
e(i)=A/(2*sqrt(2*pi))*1/(t(i)*sqrt(t(i)))*exp(-(B*B)/(2*t(i)))/26.5e11;
end
e(1)=0;
%time=linspace(dT,T,N);
%t2=sqrt(2*time);
%c1=zeros([1 N]);
%for i=1:N
%    t3(i)=c/t2(i);
%end
%G=erfc(t3); %Gaussian complementary integral

%for i=1:N
%   if i>nt1
%      G(i)=1.0-G(i-nt1);
%end
%end
%*****************
%convolution
C0=35/200*conv(e,o0);
C1=16/90*conv(e,o1);
C2=20/110*conv(e,o2);
%*****************

fid = fopen('D:\matlaba\input.dat','w');
fprintf(fid,'(Waveform\n (numDims 1)\n (size %d)\n (dim 1\n  (extent 0 1.000000000000001E-006)\n )\n (data \n [',(N));
fprintf(fid,'%12.8f',o0);
fprintf(fid,' ]\n )\n)');
fclose(fid);

k=1;
while o1(k) == 0.0 ,
   k=k+1;
end
O1=o1(k-1:N);


fid = fopen('D:\matlaba\output1.dat','w');
fprintf(fid,'(Waveform\n (numDims 1)\n (size %d)\n (dim 1\n  (extent 0 1.000000000000001E-006)\n )\n (data \n [',(N-k+1));
fprintf(fid,'%12.8f',O1);
fprintf(fid,' ]\n )\n)');
fclose(fid);

k=1;
while o2(k) == 0.0 ,
   k=k+1;
end
O2=o2(k-1:N);


fid = fopen('D:\matlaba\output2.dat','w');
fprintf(fid,'(Waveform\n (numDims 1)\n (size %d)\n (dim 1\n  (extent 0 1.000000000000001E-006)\n )\n (data \n [',(N-k+1));
fprintf(fid,'%12.8f',O2);
fprintf(fid,' ]\n )\n)');
fclose(fid);

k=1;
while C2(k) == 0.0 ,
   k=k+1;
end
C22=C2(k-1:N);


fid = fopen('D:\matlaba\convooutput2.dat','w');
fprintf(fid,'(Waveform\n (numDims 1)\n (size %d)\n (dim 1\n  (extent 0 1.000000000000001E-006)\n )\n (data \n [',(N-k+1));
fprintf(fid,'%12.8f',C22);
fprintf(fid,' ]\n )\n)');
fclose(fid);

k=1;
while C1(k) == 0.0 ,
   k=k+1;
end
C11=C1(k-1:N);


fid = fopen('D:\matlaba\convooutput1.dat','w');
fprintf(fid,'(Waveform\n (numDims 1)\n (size %d)\n (dim 1\n  (extent 0 1.000000000000001E-006)\n )\n (data \n [',(N-k+1));
fprintf(fid,'%12.8f',C11);
fprintf(fid,' ]\n )\n)');
fclose(fid);

fid = fopen('D:\matlaba\convoinput.dat','w');
fprintf(fid,'(Waveform\n (numDims 1)\n (size %d)\n (dim 1\n  (extent 0 1.000000000000001E-006)\n )\n (data \n [',(N-k+1));
fprintf(fid,'%12.8f',C0);
fprintf(fid,' ]\n )\n)');
fclose(fid);


%[a,b,c,d]=textread('D:\matov_work\MATLABa\50bignewY12.5_25_2.txt','%f %f %f %f');

figure(1);
plot(linspace(0,T,N),o0,'b');%input cable 0 rectangular
hold on;
plot(linspace(0,T,N),C0(1:N),'r');%convo
%plot(a,c,'r');
xlabel('Time [s]');
ylabel('Amplitude [V]');
title('Rectangular Response at Input');
legend('Model');
hold off;

figure(2);
plot(linspace(0,T,N),o1,'b');%end cable 1 rectangular
hold on;
plot(linspace(0,T,N),C1(1:N),'r');%convo
%plot(a,c,'r');
xlabel('Time [s]');
ylabel('Amplitude [V]');
title('Rectangular Response at Ouput 1');
legend('Model');
hold off;


figure(3);
plot(linspace(0,T,N),o2,'b');%end cable 2 rectangular
hold on;
plot(linspace(0,T,N),C2(1:N),'r');%convo
%plot(a,c,'r');
xlabel('Time [s]');
ylabel('Amplitude [V]');
title('Rectangular Response at Ouput 2');
legend('Model');
hold off;

figure(4);
plot(linspace(0,T,N),e,'b');%gaussian complementary integral
xlabel('Time [s]');
ylabel('Amplitude [V]');
title('GCI');
legend('Model');

%figure(5);
%plot(linspace(0,T,N),C2(1:N),'b');%convo
%xlabel('Time [s]');
%ylabel('Amplitude [V]');
%title('convolution input');
%legend('Model');
