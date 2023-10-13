%Normalise e1
function [e1_norm] = norma(e1)

%e1_norm = sqrt(e1);				%produces complex values ...

for i=1:length(e1),				%attention: +/- ?
   if e1(i)<0
      e1_norm(i) = sqrt(-e1(i));
      e1_norm(i) = e1_norm(i) - 2*e1_norm(i);		%to make +/-
   else
      e1_norm(i) = sqrt(e1(i));
   end
end