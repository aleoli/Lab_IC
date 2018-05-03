clear all;
close all;
clc;

%[data,Fs]=audioread('KDE_Startup.wav');
[data,Fs]=audioread('Sinfonia n. 5 (Beethoven) Il Destino bussa alla porta.mp3');
%sound(data,Fs);
Ts=1/Fs;
t=[0:Ts:(length(data)-1)*Ts];

figure;
plot(t,data(:,1));

figure;
histogram(data(:,1),200,'Normalization','probability');

F=(1/length(data(:,1))^2)*(abs(fftshift(fft(data(:,1)))).^2);

figure;
df=Fs/length(data);
f=[-Fs/2:df:Fs/2-df];
plot(f,10*log10(F));
hold on;
xlabel('Hz')
ylabel('PSD')
