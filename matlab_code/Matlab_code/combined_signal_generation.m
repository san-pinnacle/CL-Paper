function [bits,stx,ref]=combined_signal_generation(Fs,Tc,Ns,Np,Nf,Tf,w,dt,Nh)
bits=rand(1,Ns)>0.5;
bits=2*bits-1;
%bits=-1;
%% code repetation 
temp=ones(1,Nf);
temp1=zeros(1, Ns*Nf);
temp1(1:Nf:1+Nf*(Ns-1))=bits;
temp2=conv(temp1,temp);
repbits=temp2(1:Nf*Ns); %total bits after repetitation 
%numpulse=length(repbits);

%% TH coding
thcode=floor(rand(1,Np).*Nh);
%% PPM TH modulation
framesample=floor(Tf./dt);
chipsample=floor(Tc./dt);
%ppmsample=floor(dppm./dt);
Thp=length(thcode);
totallength=framesample*length(repbits);
ppmthseq=zeros(1,totallength);
thseq=zeros(1,totallength);

for k=1:length(repbits)
index=1+(k-1)*framesample; % for pulse position
kth=thcode(1+mod(k-1,Thp));
index=index+kth*chipsample;
thseq(index)=1;
ppmthseq(index)=repbits(k);
end

sa=conv(ppmthseq,w);
sb=conv(thseq,w);
L1=(floor(Tf*1./dt))*Nf*Ns;%size of transmitted pulse
stx=sa(1:L1); % modulated signal
ref=sb(1:L1);%reference siagnal