function mymatrix=reflexion2()

%variable values
l0=22;
l1=15;%l1 must be shorter than l2!!!!!!!
l2=18;
if l1<l2 maxlenght=l2+l0;
else maxlenght=l1+l0;
end
eps=2.4;
Zc0=50;
Zc1=50;
Zc2=50;
Zt1=33;
Zt2=55;

%constant values
c0=300000000;
N=126;
M=500;

%reflexion factors of lines
reflex1=(Zc1-Zt1)/(Zc1+Zt1);
reflex2=(Zc2-Zt2)/(Zc2+Zt2);

%propagation velocity in lines
v=c0/eps;

%create timebasevector
time=linspace(0,0.000001,N);

%create placebasevector
place=linspace(0,maxlenght,N);

%calculate steigung
steigung_up=v.*time
steigung_down=-v.*time;

%creatre mymatrix in 2 dim (third axis will take percentage
mymatrix=zeros(N,M);
for a=1:M
   for b=N:1
      mymatrix(b,a)b/N*maxlenght
      
mesh(mymatrix);

