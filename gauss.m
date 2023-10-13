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

