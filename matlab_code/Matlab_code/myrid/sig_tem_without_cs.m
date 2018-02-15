 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ber,z1]=sig_tem_without_cs(R,bits,numbits,bitsample,ref2,S);
%%% Hard decision detection 
[N,~]=size(R);
rxbits=zeros(N,numbits);
 for n=1:N % for length of snr 
   rx2=R(n,:); 
 for nb=1:numbits  %% for bits
        mkk=rx2(1+(nb-1)*bitsample:bitsample+(nb-1)*bitsample);
        mkk1(1:S,:)=ref2(1:S,1+(nb-1)*bitsample:bitsample+(nb-1)*bitsample);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        z1=zeros(S,1);
 K=.0001; mu=.01; %%  It can change suitably. 
       for ll=1:S
         z1(ll)=sum(mkk.*mkk1(ll,:));
          pp1(ll)=(K^2+(z1(ll)+mu)^2);
          pp2(ll)=(K^2+(z1(ll)-mu)^2);
       end
         
        
       zp=prod(pp1)-prod(pp2); 
              if zp>=0
            rxbits(n,nb)=1;
              else
            rxbits(n,nb)=-1;
              end
     end
 end
ber=zeros(1,N);
 for  n=1:N
        wb=sum(abs(bits-rxbits(n,:)));
        ber(n)=wb./numbits;
 end
    
    
 clear rxbits NOO NO1 zp mk2 mk1    mkkp  mkd1 mkd2  zp S
 clear mkk NN1 M N L wb kl mk_window1 mk_window2 nb
        
    