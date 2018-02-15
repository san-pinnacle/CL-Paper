function [ber]=cp0801_rx(R,bits,numbits,bitsample,ref1)
%%% Hard decision detection 
[N,L]=size(R);
rxbits=zeros(N,numbits);
 for n=1:N % for length of snr 
     rx2=R(n,:);
%      for ii=1:length(rx22)
% %          if abs(rx22(ii))<=1;
% %          rx2(ii)=rx22(ii);
% %          else
% %             rx2(ii)=0; 
% %          end
%          %%% limitter
%          if rx22(ii)>1
%             rx22(ii)=1;
%         elseif rx22(ii)<-1
%              rx22(ii)=-1;
%         end
%      end
%      rx2=rx22;
  %% iterative approach
% rx2=[0 rx2 0];
% [Y,I]=max(abs(rx2));
%  while (abs(rx2(I))-abs(rx2(I+1))>.5)||(abs(rx2(I))-abs(rx2(I-1))>.5)
%      rx2(I)=0;
%    [Y,I]=max(abs(rx2));
%  end
%  rx2=rx2(2:end-1);
%% receiver design 
  for nb=1:numbits  %% for bits
        mkk=rx2(1+(nb-1)*bitsample:bitsample+(nb-1)*bitsample);
        mkk1=ref1(1+(nb-1)*bitsample:bitsample+(nb-1)*bitsample);
            zp=sum(mkk.*mkk1);
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
    
    
 clear rxbits NOO NO1 zp mk2 mk1    mkkp  mkd1 mkd2 
 clear mkk NN1 M N L wb kl mk_window1 mk_window2 nb
        
    