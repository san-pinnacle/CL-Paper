
%Disclaimer: This is a code package related to the following paper:
%Sanjeev Sharma, Vimal Bhatia, and Anubha Gupta, “Impulse Noise Mitigation in IR-UWB Communication using Signal Cluster Sparsity,”
%IEEE Communication Letters, vol. PP, no. 99, December 2017.The package contains a simulation environment, based on Matlab that 
%reproduces the numerical results and figures in the article. If you use this code, then please cite our original article listed above.
%Further, this matlab code may not be efficient. 


clc;
clear all;
close all;
%% UWB pulse generation
t=linspace(-1e-9,1e-9,25);
dt=t(2)-t(1);
Fs=1/dt;
tau=.4e-9; %% pulsse width parameter
w=(1-(4*pi.*(t/tau).^2)).*exp(-2*pi.*(t/tau).^2); % second derivative 
w=w/norm(w);
%%%%%%%%%%%%%%%%%
Ns=100; % numer of data bits
Np=100; %% pilot symols
Nh=10;
Nf=1; %pulse repetation
Tf=100e-9; % frame duration
%Tf=150e-9; % frame duration %% for CM4
Tc=1e-9; %%% chip duration
L=floor(Tf*Fs);
[bits, stx,ref]=combined_signal_generation(Fs,Tc,Ns,Np,Nf,Tf,w,dt,Nh);
%ebno=inf;
ebno=0:3:30;
load('cir_industrial_nlos.mat');

MM=2;
ber1=zeros(MM,length(ebno));
for j=1:MM
hf=cir_industrial_nlos(j,:);
%% received signal
srx=conv(stx,hf);
srx=srx(1:length(stx));
%% channel estimation
PP=30; S=30; %% may be change 
[arake, srake,prake]=channel_estimation(hf,Fs,2e-9,PP,S);
%% noise generrtation
[~,noise, noise_imp]=cp0801_noise_Ex(srx,ebno,Ns);
 R=zeros(length(ebno),length(srx));
 for l=1:length(ebno)
R(l,:)=noise(l,:)+srx+noise_imp;
 end
Srake=zeros(S,L);
ref1=zeros(S,length(stx));
[I] = find(srake); %% non zeros tape of srake
for kk=1:length(I)
Srake(kk,I(kk))=srake(I(kk));
reff=conv(Srake(kk,:),ref);
ref1(kk,:)=reff(1:length(stx));
end
[ber1(j,:),z1]=sig_tem_without_cs(R,bits,Ns,L,ref1,S);
clear hf noise R ref2 ref1 srake areke L2 S2 tau t Tf  h0 E 
end
ber=sum(ber1)/MM;

clear L Fs ho I j I L_tot Nf Np ns prake ref srx prake stx ts w framesample framesample1
clear noise_imp kk MM Nh prake srake bits arake ber1 PP reff Srake Tc dt S Ns l

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
semilogy(ebno,ber,'-','color','k','LineWidth',1); hold on;



 