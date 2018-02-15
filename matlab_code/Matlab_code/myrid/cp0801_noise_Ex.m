function [output,noise, noise_imp]=cp0801_noise_Ex(rx,snrdb,numbits);
K=length(rx);
Eb=(1/numbits)*sum(rx.^2);
Eb=1/Eb;
Ebn0=10.^(snrdb./10);
N0=Eb./Ebn0;
nstdv=sqrt(N0./2);
 %%% impulse noise generation
  M=floor(.01*K);
  noise_imp=zeros(1,K);
  snr=-30;
 Ebn01=10.^(snr./10);
 N01=Eb./Ebn01;
 nstdv1=sqrt(N01./2);
 imp=randperm(K);
 noise_imp(imp(1:M))=nstdv1.*randn(1,M);    
for j=1:length(snrdb)
%      imp=randperm(K);
%      noise_imp(imp(1:M))=10*nstdv(j)*randn(1,M);
%      noise_imp1(j,:)= noise_imp;
    noise(j,:)=nstdv(j).*randn(1,K);%+ noise_imp1(j,:);
    %noise(j,:)=awgn(.001*rx,snrdb(j),'measured');
   output(j,:)=noise(j,:)+rx;
end