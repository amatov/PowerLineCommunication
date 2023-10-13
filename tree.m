function tree(filename)

fid = fopen(filename,'r');

T=fscanf(fid,'%f',1);	% total time of the simulation
NT=fscanf(fid,'%d',1); 	% number of 
N=fscanf(fid,'%d',1); 	% number of nodes
M=fscanf(fid,'%d',1); 	% number of cables
MR=fscanf(fid,'%d',1); 	% total number of entries in the file

I=zeros([M 1]); J=zeros([M 1]); L=zeros([M 1]);
Z=zeros([M 1]); % cable  impedances
Zterm=zeros([N 1]); % termination  impedances

c0=299792458; 	% speed of light (m/s)
eps=1.5;			% 2.05 % given by manufacurer between 2 and 2.5
v=c0/eps; 		% propagation velocity in lines
dT=T/NT;			% the smalles time interval
dl=v*dT;			% propagation for time dT

m=0;
for k=1:MR	% read all the entries from the file
	i=fscanf(fid,'%d',1);	% starting node
	j=fscanf(fid,'%d',1);   % end node
	l=fscanf(fid,'%f',1);   % length of the cable (meters)
	z=fscanf(fid,'%f',1);   % impedance (ohms)
   
   if i>j	% ensure that a cable always starts from the node with the smaller number
      ij=i; i=j; j=ij;
   end
   
   if i==0	% the entry describes a termination
      Zterm(j)=1/z;	% we only use 1/z
   elseif i>0	% the entry is regular cable
      m=m+1;
      I(m)=i; J(m)=j; L(m)=round(l/dl); Z(m)=z;
   end

end	% reading from the file

% calculate the reflection coeficients
RF=zeros([M 1]);	% reflection coefficient at the end point of the cable
RB=zeros([M 1]);	% reflection coefficient at the start point of the cable
for i=1:M
   s1=Zterm(J(i)); s2=Zterm(I(i));
	for j=1:M
      if I(j)==J(i)&i~=j
         s1=s1+1/Z(j);
      end   
      if (I(j)==I(i)|J(j)==I(i))&i~=j
         s2=s2+1/Z(j);
      end   		
   end
	RF(i)=(1/s1-Z(i))/(1/s1+Z(i));   RB(i)=(1/s2-Z(i))/(1/s2+Z(i));   
end

input_divider = Z(1)/(Z(1)+1/Zterm(1));

maxL = max(L);	% needed for the dimensions of fp and bp

fp=zeros([M maxL]);	% forward propagation
bp=zeros([M maxL]);	% back propagation
O=zeros([N NT]);		% output values for all nodes
input=zeros([M 1]); 	% pointer to the input value for each cable
output=zeros([M 1]); % pointer to the output value for each cable

% generate an input signal (rectangular)
input_signal=1*ones([NT 1]);
for i=126:NT
   input_signal(i)=0;
end

% main loop
for i=1:NT
   
   % determine the position of the input and the output
   for j=1:M
      input(j)=mod(i, L(j))+1;  
      output(j)=mod(i+1, L(j))+1;
   end
      
   for j=1:M	% for each cable
      % the initial values are the internal reflections at both ends of cable #j
      sf=bp(j,output(j))*RB(j);	sb=fp(j,output(j))*RF(j);
      for k=1:M	% for each possible pair of cabbles (#j,#k)
         if k~=j	% the case k==j is handled by the initial values
		      % forward propagation
         	if I(k)==I(j)	% if cable #k starts at the node at which cable #j starts
            	sf=sf+bp(k,output(k))*(1-RB(k));
         	elseif J(k)==I(j)	% if cable #k ends at the node at which cable #j starts
            	sf=sf+fp(k,output(k))*(1-RF(k));
            end
		      % back propagation
	         if I(k)==J(j)	% if cable #k starts at the node at which cable #j ends
   	         sb=sb+bp(k,output(k))*(1-RB(k));
      	   end	%only one cable can end at any node
         end
      end
      fp(j,input(j))=sf;	bp(j,input(j))=sb;
      
   end
   
   % apply the input to node #1
   fp(1,input(1))=fp(1,input(1))+input_signal(i)*input_divider;
   
	% determine the output from each node
   for j=1:N
      s=0;
      for k=1:M
         if I(k)==j	%if cable #k starts at node #j
            s=s+bp(k,output(k))+fp(k,input(k));
         elseif J(k)==j	% if cable #k ends at node #j
            s=s+fp(k,output(k))+bp(k,input(k));
         end
      end
      O(j,i)=s;
   end
   O(1,i)=O(1,i);%+fp(1,input(1));
   
end	% main loop

plot(linspace(0,T,NT),O(2,:),'r');
hold on;
%plot(linspace(0,T,NT),O(3,:),'r');