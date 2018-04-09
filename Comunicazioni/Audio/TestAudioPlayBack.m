close all
clear all
clc

%Create an audiorecorder object for CD-quality audio in stereo, and view its properties:

load furelise.mat
%load DOcentrale.mat
% load DOalto.mat

play(recObj);

fs=recObj.sampleRate;

% Plot the waveform.
figure;
plot(myRecording(:,1));

figure;
histogram(myRecording(:,1),200,'Normalization','probability');

df=fs/length(myRecording(:,1));
f=[-fs/2:df:fs/2-df];
F=(1/length(myRecording(:,1))^2)*(abs(fftshift(fft(myRecording(:,1)))).^2);

figure;
plot(f,(F))
hold on;
xlabel('Hz')
ylabel('PSD')

