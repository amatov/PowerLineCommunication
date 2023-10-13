function G(N)

T=1e-6;
dT=T/N;
c=0.3;

time=linspace(dT,T,N);
t2=sqrt(2*time);
c1=zeros([1 N]);
for i=1:N
    t3(i)=c/t2(i);
    
G=erfc(t3); %Gaussian complementary integral
end

%for i=1:N
%   if i>nt1
%      G(i)=1.0-G(i-nt1);
%end
%end

% Compute an approximation of the Complementary Gaussian Integral function.
% Returns the step response, function of Gc(x).


function[G]=gauss(T,k)

[m,n]=size(T);

for j=1:n
 x=k*T(j);
 if x>0
  G(j)=erfc(1/sqrt(2*x));
 else
  G(j)=0;
 end;
end;

figure(1);
plot(linspace(0,T,N),G,'b');%gaussian complementary integral
xlabel('Time [s]');
ylabel('Amplitude [V]');
title('GCI');
%legend('Model');