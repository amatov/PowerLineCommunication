function twograph2512(N)

%HowTo
%-----
%We consider here 3 cables: At the end of the first the both(l0), the second (l1) and the third (l2)are connected simultainusely.
%Always use a round number of points plus one to obtain perfect results without bugs!
%For example (101,201,301...): If you take more than 301 points your PC will take quite a while to calculate the matrix
%Maindatainputs: 	Zc0 = caracteristic impedance of startcable (l0)
%						Zc1 = caracteristic impedance of long cable (l1)
%						Zc2 = caracteristic impedance of short cable(l2)
%						l0  = lenght in meters of startcable (l0)
%						l1  = lenght in meters of long cable (l1)
%						l2  = lenght in meters of short cable(l3)
%						Zt1 = termination impedance of long cable (l1)
%						Zt1 = termination impedance of short cable(l2)
%						N = Number of calculationpoints used for time- and distancedimension of matrix
Zc0=27;
Zc1=45;
Zc2=27;
Zt1=150;
Zt2=50;
l0=10;
l1=30;
l2=10;

%Programstart:
%-------------
%variable values testing
if l2>l1 %l2 must be shorter than l1
   a=input('l2 must be shorter than l1....Please correct! Press Enter!');
   exit;
end

%constant values
%c0=299792458; works better with approximation:  
c0=300000000;
startimp=50;
generatorvoltage=2;
maxlenght=l1+l0;
eps=1.5;%given by manufacurer between 2 and 2.5

%reflexion factors of lines
start=1-(generatorvoltage/((startimp/Zc0)+1));
startreflex=-(Zc0-startimp)/(Zc0+startimp);%start/entry impedance reflexion
reflex1=-(Zc1-Zt1)/(Zc1+Zt1);%termination long cable
reflex2=-(Zc2-Zt2)/(Zc2+Zt2);%termination short cable
ramreflex1=-(Zc0-(Zc1*Zc2/(Zc1+Zc2)))/(Zc0+(Zc1*Zc2/(Zc1+Zc2)));%reflexioncoefficient from startcable back to startcable
ramreflex2=-(Zc1-(Zc0*Zc2/(Zc0+Zc2)))/(Zc1+(Zc0*Zc2/(Zc0+Zc2)));%reflexioncoefficient from long cable back to long cable
ramreflex3=-(Zc2-(Zc1*Zc0/(Zc1+Zc0)))/(Zc2+(Zc1*Zc0/(Zc1+Zc0)));%reflexioncoefficient from short cable back to short cable

%propagation velocity in lines
v=c0/eps;

%create timebasevector
time=linspace(0,0.0000006666666666666,N);

%calculate ramp
steigung_up=v.*time;
steigung_down=-v.*time;

%creatre mymatrix in 2 dim (third axis will take percentage of Voltage)
mymatrix=zeros(N,N);

%fill matrix with refelxionpercentages if there is a wave, else zero
%-------------------------------------------------------------------
%startpartameters
ex='up';
firsttime=1;
firsttime2=1;
firsttime3=1;
firsttime9=1;
firsttime90=1;
firsttime99=1;
astor9=0;
astor90=0;

%great time-for-loop
for a=1:N
   for b=1:N
      switch ex
      case ('up')
         %start wavepropagation wave 1
         if (steigung_up(a)<=b/N*maxlenght & steigung_up(a)>=(b-1)/N*maxlenght)
            mymatrix(a,b)=(1-start);%consider startrefelxion at 50 Ohms
            if steigung_up(a)>l0 %wave one after separation point
               mymatrix(a,b)=mymatrix(a,b)*(1-ramreflex1)/(2);%transmission in the 2 cables
            end
            if (steigung_up(a)<=l0)
               astor8=a;
            end
         end
         if steigung_up(a)>l0
            if ((steigung_down(a-astor8)+steigung_up(astor8))<=b/N*maxlenght & (steigung_down(a-astor8)+steigung_up(astor8))>=(b-1)/N*maxlenght)
               mymatrix(a,b)=(1-start)*ramreflex1;%refelxion back to cable l0 at midconnection
            end
            if (steigung_down(a-astor8)+steigung_up(astor8))<0
               if firsttime9==1
                  firsttime9=0;
                  astor9=a-1;
                  bstor9=b;
               end
               if (steigung_up(a-astor9)<=b/N*maxlenght & steigung_up(a-astor9)>=(b-1)/N*maxlenght)
                  mymatrix(a,b)=(1-start)*ramreflex1*startreflex;%rereflexion at startpoint of the wave 1 reflected at midconnection
               end
            end
         end
         if steigung_up(a)>maxlenght-(l1-l2) 
            ex='populate1';
            astor1=a-1;
            bstor1=b;
         end
      case ('populate1')
         if (steigung_up(a-astor9)<=b/N*maxlenght & steigung_up(a-astor9)>=(b-1)/N*maxlenght)
            mymatrix(a,b)=(1-start)*ramreflex1*startreflex;%rereflexion at startpoint of the wave 1 reflected at midconnection (highlevel)
         end     
         if (steigung_up(a)<=b/N*maxlenght & steigung_up(a)>=(b-1)/N*maxlenght)
            mymatrix(a,b)=(1-start);%1 wave out (highlevel)
            if steigung_up(a)>l0 
               mymatrix(a,b)=mymatrix(a,b)*(1-ramreflex1)/(2);%transmission in the 2 cables (highlevel)
            end
            astor2=a-1;
            bstor2=b;
         end
         if steigung_up(a)>maxlenght
            if ((steigung_down(a-astor2)+steigung_up(astor2))<=b/N*maxlenght & (steigung_down(a-astor2)+steigung_up(astor2))>=(b-1)/N*maxlenght)
               mymatrix(a,b)=(1-start)*(1-ramreflex1)/(2)*reflex1;%reflexion of wave 1 at thge end of long cable 
               if (steigung_down(a-astor2)+steigung_up(astor2))<l0+l2 &(steigung_down(a-astor2)+steigung_up(astor2))>l0
                  mymatrix(a,b)=0;%this reflexion of long cable is not visible on short cable!
               end
               if (steigung_down(a-astor2)+steigung_up(astor2))<l0 
                  mymatrix(a,b)=mymatrix(a,b)*(1-ramreflex2)/(2);%back from reflexion at the end of long cable: transmission at midconnection into startcable
               end
            end
            
            if (steigung_down(a-astor2)+steigung_up(astor2))<0
               if firsttime90==1
                  firsttime90=0;
                  astor90=a-1;
                  bstor90=b;
               end
               if (steigung_up(a-astor90)<=b/N*maxlenght & steigung_up(a-astor90)>=(b-1)/N*maxlenght)
                  mymatrix(a,b)=(1-start)*(1-ramreflex1)/(2)*reflex1*(1-ramreflex2)/(2)*startreflex;
                  %back from reflexion of long cable through midconnetion and reflexion at the start again!
               end
            end
            
            if (steigung_down(a-astor2)+steigung_up(astor2))<l0
               if firsttime3==1
                  firsttime3=0;
                  astor5=a-1;
                  bstor5=b;
               end
               if ((steigung_up(a-astor5)+l0)<=b/N*maxlenght & (steigung_up(a-astor5)+l0)>=(b-1)/N*maxlenght)
                  mymatrix(a,b)=(1-start)*(1-ramreflex1)/(2)*reflex1*(1-ramreflex2)/(2);
                  %propagation back from reflexion at end of long cable and transmission at midconnection to short cable!
                  if (steigung_up(a-astor5)+l0)>(l0+l2)
                     mymatrix(a,b)=(1-start)*(1-ramreflex1)/(2)*reflex1*ramreflex2;
                     %now reflexion is visble in long cable
                  end
               end
            end
         end
         if ((steigung_down(a-astor1)+steigung_up(astor1))<=b/N*maxlenght & (steigung_down(a-astor1)+steigung_up(astor1))>=(b-1)/N*maxlenght)
            mymatrix(a,b)=(1-start)*(1-ramreflex1)/(2)*reflex2;%first wave goes in to short cable at midconnection and is reflected at end of short cable
            if (steigung_down(a-astor1)+steigung_up(astor1))<l0 
               mymatrix(a,b)=mymatrix(a,b)*(1-ramreflex3)/(2);%first wave refelcted at end of short cable and goes back in startcable at midconnection 
            end
         end
         if (steigung_down(a-astor1)+steigung_up(astor1))<l0
            if firsttime==1
               firsttime=0;
               astor3=a-1;
               bstor3=b;
            end
            if ((steigung_up(a-astor3)+l0)<=b/N*maxlenght & (steigung_up(a-astor3)+l0)>=(b-1)/N*maxlenght)
               mymatrix(a,b)=(1-start)*(1-ramreflex1)/(2)*reflex2*(1-ramreflex3)/(2);%first wave reflected at end of short cable and now turns into long cable at midconnection!
               if (steigung_up(a-astor3)+l0)>l0 & (steigung_up(a-astor3)+l0)<(l0+l2);
                  mymatrix(a,b)=(1-start)*(1-ramreflex1)/(2)*reflex2*ramreflex3;%only short cable is visible between shortcable distance
               end
            end
         end
         if (steigung_down(a-astor1)+steigung_up(astor1))<0
            if firsttime2==1
               firsttime2=0;
               astor4=a-1;
            end
            if (steigung_up(a-astor4)<=b/N*maxlenght) & (steigung_up(a-astor4)>=(b-1)/N*maxlenght)
               mymatrix(a,b)=(1-start)*(1-ramreflex1)/(2)*reflex2*(1-ramreflex3)/(2)*startreflex;
               %first wave reflected at end of short cable going back to stat of startcable and is reflected back into startcable
            end
         end   
      end
   end
end

%%printout all calculations
%%Wave in function of time Plot
figure(1);
%colormap(1-gray);NO
colormap(hsv(128));
%colormap(1-copper);NO
imagesc(linspace(0,0.000001,N),linspace(0,(l0+l1),N),mymatrix.');
xlabel('Time [s]');
ylabel('Distance [m]');
title('Propagation Time');

%%3-D figure with Voltage, Place and Time of impulsions
%figure(2);
%mesh(linspace(0,0.000001,N),linspace(0,(l0+l1),N),mymatrix.');
%axis([0,0.000001,0,(l0+l1),-1.5,1.5]);
%xlabel('Time [Seconds]');
%ylabel('Place [Meters]');
%zlabel('Voltage [Volts]');
%title('Impuls-Response');

%%3-D figure with Voltage, Place and Time of step-response
figure(3);
%%correction of negative values
mymatrix2=cumsum(mymatrix,1);
for i=1:N
   for j=1:N
      if mymatrix2(i,j)<0 
         mymatrix2(i,j)=0;
      end
   end
end
mymatrix3=mymatrix2;
%%put to markers on figure 3 for location of cable-ends
for i=1:N
   for j=1:N
      if j==round(N*l0/maxlenght)
         mymatrix2(i,j)=0.2;
      end
      if j==round(N*(l0+l2)/maxlenght)
         mymatrix2(i,j)=0.2;
      end
   end
end
mesh(linspace(0,0.000001,N),linspace(0,(l0+l1),N),mymatrix2.');
axis([0,0.000001,0,(l0+l1),0,1]);
xlabel('Time [s]');
ylabel('Distance [m]');
zlabel('Amplitude [V]');
title('Step Response');

%Printout Voltage in function of time at a special place 
figure(4);
plot(linspace(0,0.000001,N),mymatrix3(:,1),'b');% entrance
[a,b,c,d]=textread('D:\MATLABa\50bignewY12.5_25_2.txt','%f %f %f %f');
hold on;
plot(a,b,'r');
xlabel('Time [s]');
ylabel('Amplitude [V]');
title('Step Response at Input');
legend('Model', 'Measurement');
hold off;
%figure(5);
%plot(linspace(0,0.000001,N),mymatrix3(:,(round(N*l0/maxlenght)+1)));% midconnection
%xlabel('Time [Seconds]');
%ylabel('Voltage [Volt]');
%title('Step-Response at midconnection');

figure(6);
plot(linspace(0,0.000001,N),mymatrix3(:,(round(N*(l0+l2)/maxlenght)-3)),'b');%end cable 2
hold on;
plot(a,c,'r');
xlabel('Time [s]');
ylabel('Amplitude [V]');
title('Step Response at Ouput 2');
legend('Model','Measurement');
hold off;
figure(7);
plot(linspace(0,0.000001,N),mymatrix3(:,N-7),'b');%end cable 1
hold on;
plot(a,d,'r');
xlabel('Time [s]');
ylabel('Amplitude [V]');
title('Step Response at Output 1');
legend('Model', 'Measurement');
hold off;
