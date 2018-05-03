close all
clear all
clc

%Create an audiorecorder object
fs=16000;
Tc=1/fs;
recObj = audiorecorder(fs,16, 1);
get(recObj)

%Collect a sample of your speech with a microphone, and plot the signal
% Record your voice for 5 seconds
disp('Start speaking.')
recordblocking(recObj,6);
disp('End of Recording.');

% Play back the recording.
play(recObj);

% Store data in double-precision array.
myRecording = getaudiodata(recObj);
t=Tc*[1:length(myRecording)];

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
grid on;

figure;
plot(f,10*log10(F))
hold on;
xlabel('Hz')
ylabel('PSD')
grid on;

% save speaking.mat