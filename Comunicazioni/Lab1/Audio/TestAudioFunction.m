close all
clear all
clc

fs=32000;
t=[0:1/fs:2];

a1=0;
a2=2;
freq1=20;
freq2=1000;
y=a1*sin(2*pi*freq1*t)+a2*sin(2*pi*freq2*t);

recObj=audioplayer(y,fs);

% Play back the recording.
play(recObj);

% Store data in double-precision array.
myRecording =y;

% Plot the waveform.
figure;
plot(myRecording);

figure;
histogram(myRecording,200,'Normalization','probability');

df=fs/length(myRecording);
f=[-fs/2:df:fs/2-df];
F=(1/length(myRecording)^2)*(abs(fftshift(fft(myRecording))).^2);

figure;
plot(f,10*log10(F))
hold on;
xlabel('Hz')
ylabel('PSD')