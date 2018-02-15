
%Disclaimer: This is a code package related to the following paper:
%Sanjeev Sharma, Vimal Bhatia, and Anubha Gupta, “Impulse Noise Mitigation in IR-UWB Communication using Signal Cluster Sparsity,”
%IEEE Communication Letters, vol. PP, no. 99, December 2017.The package contains a simulation environment, based on Matlab that 
%reproduces the numerical results and figures in the article. If you use this code, then please cite our original article listed above.
%Further, this matlab code may not be efficient. 

%% SALSA receiver can be generted using the code avaible at : file:///G:/Ivan%20_Compressive%20sensing/SALSA_toolbox/SALSA_toolbox/readme.html
%% Myriad reciver is given in another folder
%%
clc;
clear all;
close all;
%% UWB pulse generation
t=linspace(-1e-9,1e-9,33);
dt=t(2)-t(1);
Fs=1/dt;
tau=.4e-9; %% pulsse width parameter
w=(1-(4*pi.*(t/tau).^2)).*exp(-2*pi.*(t/tau).^2); % second derivative 
w=w/norm(w);
%%%%%%%%%%%%%%%%%
Ns=1; % numer of data bits and can change 
Np=100; %% pilot symols
Nh=3;
Nf=1; %pulse repetation
Tf=60e-9; % frame duration
Tc=1e-9; %%% chip duration
E=1; %% pulse energy
L=floor(Tf*Fs);
ns=L;
[bits, stx,ref]=combined_signal_generation(Fs,Tc,Ns,Np,Nf,Tf,w,dt,Nh);
%ebno=inf;
ebno=-30:3:30; %% for example
MM=100;
ber1=zeros(MM,length(ebno));% initialization
 for j=1:MM
[~,hf]=channel_generation(Fs,1, L); %% For example 
%% received signal
srx=conv(stx,hf);
srx=srx(1:length(stx));
%% noise generrtation
[noise,noise_imp]=cp0801_noise_Ex(stx,ebno,Ns); %% noise is added with respect to the tranmitted signal power. However, noise can add with respect to the
% received signal power
 R=zeros(length(ebno),length(srx));
 for l=1:length(ebno)
R(l,:)=srx+noise(l,:)+noise_imp; %% without IN, noise_imp should removed
 end
%  %% reference signal
 ref1=mask_generation(ref,hf,Ns);
%[ber1(j,:)]=receiver_simple(R,bits,Ns,L,ref1);
%[ber1(j,:)]=receiver_limiter_2(R,bits,Ns,L,ref1);
[ber1(j,:)]=receiver_cda(R,bits,Ns,L,ref1);

clear hf noise R ref2 ref1 srake areke L2 S2 tau t Tf  h0 E dt
end
ber=sum(ber1)/MM;
clear srx ref ref1 ho bits ber1 w Tc output Nh Np L i j Ns ns Nf Fs stx noise_imp l 


semilogy(ebno,ber,'-','color','k','LineWidth',1); hold on;

