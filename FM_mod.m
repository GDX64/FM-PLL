clear all
close all
clc


MI=[0.1272    4.5396    0.0507]*1e4; %Pll constants
nL=0.1; %noise level
bitRate=16; %Hz
sc=10; %scale factor for the integration process
f0=2000; %central frequency
ppc=128; %points per cicle
Nbits=100; %Number of random bits
msg_original=randi([0 1],1,Nbits); %message to be trasmited
Fs=f0*ppc; %sample frequency
T_bit=1/bitRate; %bit period
t_end=length(msg_original)*T_bit; %end time
N=round(t_end*Fs); %number of samples
t=linspace(0,t_end,N); %time vector

msg=repelem(msg_original,10); %That's for the ~linear~ ZOH interpolation
interp_msg=interp1(linspace(0,t_end,length(msg)),msg,t); %interpolation of message with time
theta_m=sc*cumsum(interp_msg)/Fs; %message integral
theta_m=theta_m+2*randn(1,length(theta_m));%phase noise

s=sin(f0*2*pi*t+theta_m)+randn(1,N)*nL; %signal transmited

figure
plot(interp_msg)
title('mensagem interpolada')
figure
plot(theta_m)
title('theta_m')

figure
plot(s)
title('sinal')
%% Demodulação
[A,w,fi,y,e] = EPLL(s,MI,1/Fs,f0);

figure
subplot(2,1,1)
plot(t,e)
title('erro')
subplot(2,1,2)
plot(t,w)
title('frequência')
figure
w2=filter(ones(1,10)/10,1,w);
msg_dem=w2-f0*2*pi;
plot(t,msg_dem)
axis([0 t(end) -sc 2*sc])
title('Msg')

figure
periodogram(s)


msg_dem=decan(msg_dem>5,16000);
plot(msg_dem)
ber= 1-sum(msg_dem==msg_original)/length(msg_dem)