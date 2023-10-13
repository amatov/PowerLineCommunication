function [place,placeAdd]=calculate3(place,N,l1,l2,seq)
s=1;
for i=1:N,
   if place(i)>=(l1+l2) 
      place(i)=(l1+l2)-(place(i)-l1-l2);
      if seq==1
         if place(i)<l1
            place(i)=2*l1-place(i);
            if place(i)>=(l1+l2)
               place(i)=(l1+l2)-(place(i)-l1-l2);
               if place(i)<l1
                  if s
                     placeAdd=place;
                     s=0;
                  end
                  placeAdd(i)=place(i);
                  place(i)=2*l1-place(i);
                  if place(i)>=(l1+l2)
                     place(i)=(l1+l2)-(place(i)-l1-l2);                  
                     if place(i)<l1
                        place(i)=2*l1-place(i);
                        if place(i)>=(l1+l2)
                           place(i)=2*(l1+l2)-place(i);
                        end
                     end
                  end
                  if placeAdd(i)<=0
                     placeAdd(i)=-placeAdd(i);
                  end
               end
            end
         end
      elseif seq==2
         if place(i)<0
            place(i)=-place(i);
            if place(i)>=(l1+l2) 
               place(i)=(l1+l2)-(place(i)-l1-l2);
               if place(i)<l1
                  place(i)=2*l1-place(i);
                  if place(i)>=(l1+l2)
                     place(i)=(l1+l2)-(place(i)-l1-l2);
                     if place(i)<l1
                        place(i)=2*l1-place(i);
                        if place(i)<l1
                           place(i)=2*l1-place(i);
                        end
                     end
                  end
               end
            end
         end      
      elseif seq==3
         if place(i)<0
            place(i)=-place(i);
            if place(i)>=(l1+l2) 
               place(i)=(l1+l2)-(place(i)-l1-l2);
               if place(i)<l1
                  place(i)=2*l1-place(i);
                  if place(i)>=(l1+l2)
                     place(i)=(l1+l2)-(place(i)-l1-l2);
                     if place(i)<l1
                        place(i)=2*l1-place(i);
                        if place(i)<l1
                           place(i)=2*l1-place(i);
                        end
                     end
                  end
               end
            end
         end
      end
   end
end
