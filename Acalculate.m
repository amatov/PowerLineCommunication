function [place]=calculate(place,N,l1)

for i=1:N,
   if place(i)>=l1 
      place(i)=l1-(place(i)-l1);
      if place(i)<=0
         place(i)=-place(i);
         if place(i)>=l1
            place(i)=l1-(place(i)-l1);
            if place(i)<=0
               place(i)=-place(i);
               if place(i)>=l1
                  place(i)=l1-(place(i)-l1);
                  if place(i)<=0
                     place(i)=-place(i);
                     if place(i)>=l1
                        place(i)=l1-(place(i)-l1); if place(i)<=0
                           place(i)=-place(i);
                           if place(i)>=l1
                              place(i)=l1-(place(i)-l1);
                              if place(i)<=0
                                 place(i)=-place(i);
                                 if place(i)>=l1
                                    place(i)=l1-(place(i)-l1);
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
            end
         end
      end
   end
end
