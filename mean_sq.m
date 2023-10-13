Err= ones(8, 13);
[taille tmp]= max(size(y_17));
i=0;j=0 
for delay= 10:20:250
 i= i+1; 
 delay
 for par= 50:20:200
  j= j+1;  
  Err(i, j)=sum((y_17'- Gauss(taille, par, delay).^2));
 end
 j=0;
end

delay_axis= 10:20:250;
par_axis= 50:20:200;

figure
surf(delay_axis, par_axis, Err)