function [place]=calculate2(place,N,l1,l2,seq)

for i=1:N,
   if place(i)>=l1 
      place(i)=l1-(place(i)-l1);
      if place(i)<=0
         place(i)=-place(i);
         if seq==1
            if place(i)>=(l1+l2)
               place(i)=(l1+l2)-(place(i)-(l1+l2));
            end
         else 
            if place(i)>=l1
               place(i)=l1-(place(i)-l1);
            end
         end
         if place(i)<=0
            place(i)=-place(i);
            if seq==2
               if place(i)>=(l1+l2)
                  place(i)=(l1+l2)-(place(i)-(l1+l2));
               end
            else 
               if place(i)>=l1
                  place(i)=l1-(place(i)-l1);
               end
            end               
            if place(i)<=0
               place(i)=-place(i);
               if seq==3
                  if place(i)>=(l1+l2)
                     place(i)=(l1+l2)-(place(i)-(l1+l2));
                  end
               else 
                  if place(i)>=l1
                     place(i)=l1-(place(i)-l1);
                  end
               end    
               if place(i)<=0
                  place(i)=-place(i);
                  if seq==4
                     if place(i)>=(l1+l2)
                        place(i)=(l1+l2)-(place(i)-(l1+l2));
                     end
                  else 
                     if place(i)>=l1
                        place(i)=l1-(place(i)-l1);
                     end
                  end   
                  if place(i)<=0
                     place(i)=-place(i);
                     if seq==5
                        if place(i)>=(l1+l2)
                           place(i)=(l1+l2)-(place(i)-(l1+l2));
                        end
                     else 
                        if place(i)>=l1
                           place(i)=l1-(place(i)-l1);
                        end
                     end   
                     if place(i)<=0
                        place(i)=0;   
                     end
                  end
               end
            end
         end
      end
   end         
end