function [arake, srake,prake]=channel_estimation(hf,fc,ts,L,S)
dt=1/fc;
ahf=abs(hf);
[sval,sind]=sort(ahf);
Nf=0;
i=length(sind);
j=0;
while (sval(i)>0)&&(i>0);
    Nf=Nf+1;
    j=j+1;
    index=sind(i);
    I(j)=index;
    T(j)=(index-1)*dt;
    G(j)=hf(index);
    i=i-1;
end
binsample=floor(ts/dt);
if S>Nf
    S=Nf;
end
if L>Nf
    L=Nf;
end
% arake=zeros(1,Nf*binsample);
% srake=zeros(1,Nf*binsample);
% prake=zeros(1,Nf*binsample);
arake=zeros(1,599);
srake=zeros(1,599);
prake=zeros(1,599);
%%%%%for rake 
for nf=1:Nf
    x=I(nf);
    y=G(nf);
    arake(x)=y;
    if nf<=S
        srake(x)=y;
    end 
end
[tv, ti]= sort(T);
TV=tv(1:L);
TI=ti(1:L);
tc=0;
for n1=1:length(TV)
    index=TI(n1);
    x=I(index);
     y=G(index);
      prake(x)=y;
      tc=tc+1;
      L=L-1;
end

 ns=length(hf);      
srake1=zeros(1,ns);
if length(srake)<ns
   srake1(1:length(srake))=srake(1:end);
else
    srake1=srake(1:ns);
end
srake=srake1;
clear srake1         
        
        
    