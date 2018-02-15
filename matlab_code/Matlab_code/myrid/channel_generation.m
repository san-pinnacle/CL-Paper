function [ho, hf]=channel_generation(fc,tmg,MM);
ot=100e-9;
ts=2e-9;
%channel CM1
Lamda=0.0233e9;
lamda=2.5e9;
Gamma=7.1e-9;
gamma=4.3e-9;

% % %channel CM3
% Lamda=0.0667e9;
% lamda=2.1e9;
% Gamma=14e-9;
% gamma=7.9e-9;
%% CM4 channel
% Lamda=0.0667e9;
% lamda=2.1e9;
% Gamma=24e-9;
% gamma=12e-9;

%%%%%%%%%%%%%%%%%%
sigma1=10^(3.3941/10);
sigma2=10^(3.3941/10);
sigmax=10^(3/10); %log-normal shadowing
rdt=0.001; % ray decay threshold
pt=50;% paek threshold in db
dt=1/fc;
T=1/Lamda;
t=1/lamda;
i=1;
cat(i)=0;
next=0;
while next<ot
    i=i+1;
    next =next+expinv(rand,T);
    if next< ot
        cat(i)=next;
    end
end
nc=length(cat);
logvar=(1/20)*(sigma1^2)+(sigma2^2)*log(10);
omega=1;
pc=0;

for i=1:nc
    pc=pc+1;
    ct=cat(i);
    ht(pc)=ct;
    next=0;
    mx=10*log(omega)-(10*ct/Gamma);
    mu=(mx/log(10))-logvar;
    a=10^((mu+(sigma1*randn)+(sigma2*randn))/20);
    ha(pc)=((rand>0.5)*2-1).*a;
    ccoeff=sigma1*randn;
    while exp(-next/gamma)>rdt
        pc=pc+1;
        next=next+expinv(rand,t);
        ht(pc)=ct+next;
        mx=10*log(omega)-(10*ct/Gamma)-(10*next/Gamma);
        mu=(mx/log(10)-logvar);
        a=10^((mu+ccoeff+(sigma2*randn))/20);
        ha(pc)=((rand>0.5)*2-1).*a;
    end
end
%%%%%%%%weal peak filtering
peak=abs(max(ha));
limit=peak/10^(pt/10);
ha=ha.*(abs(ha)>(limit.*ones(1,length(ha))));
for i=1:pc
    itk=floor(ht(i)/dt);
    h(itk+1)=ha(i);
end
%%%%%%%%discret time impulse responce
N=floor(ts/dt);
L=N*ceil(length(h)/N);
ho=zeros(1,L);
hf=ho;
ho(1:length(h))=h;
for i=1:(length(ho)/N)
    tmp=0;
    for j=1:N
        tmp=tmp+ho(j+(i-1)*N);
    end
    hf(1+(i-1)*N)=tmp;
end
%%%%%%%%energy normalization
etot=sum(h.^2);
ho=ho/sqrt(etot);
etot=sum(hf.^2);
hf=hf/sqrt(etot);
%%%%%%log normal shadowing
mux=((10*log(tmg))/log(10))-(((sigmax^2)*log(10)/20));
X=10^((mux+(sigmax*randn))/20);
ho=X.*ho;
hf=X.*hf;
% MM=2500; %% for 150 nanosecond
%MM=1100; %% for 100 nanosecond
%MM=1300; %% for 800 nanosecond
hf1=zeros(1,MM);  
if length(hf)<MM;
    hf1(1:length(hf))=hf(1:end);
else
    hf1(1:MM)=hf(1:MM);
end
clear hf
hf=hf1;
clear etot  X mux tmp j N L i pc peak limit 
clear ha mx ct pc next omega T t  ot ts 
