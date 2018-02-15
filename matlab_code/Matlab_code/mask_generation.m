function [mask]=mask_generation(ref,arake,Ns)
LR=length(ref);
%Epulse=(sum(((ref.^2).*dt)))/numpulse;
%Epulse=(1/Ns)*sum(ref.^2);

Epulse=1;
nref=ref./sqrt(Epulse);
mref=conv(nref,arake);
mask=mref(1:LR);
