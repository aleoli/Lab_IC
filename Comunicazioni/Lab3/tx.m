clear all
close all

[data,Fs]=audioread('../Lab1/Audio/KDE_Startup.wav');
data=data(:,1)';

V = max(abs(data));
nbit=1;
M=2^nbit;
DeltaV=2*V/M;
pe=1e-5;
Tc = 1/Fs;
SpS = 100;
Fc = Fs;
Rs = Fc/SpS;
%B = 1/(2*Tc);

data_ = data*(1/V);

f0 = 10000;
f_cos = cos(2*pi*f0*[0:Tc:(Tc*length(data_) - Tc)]);
data_mod = f_cos .* data_;

partition=[-V+DeltaV:DeltaV:V-DeltaV];
codebook=[-V+DeltaV/2:DeltaV:V-DeltaV/2];
[index,quants]=quantiz(data_mod,partition,codebook);

word=de2bi(index,nbit)';

figure(1)
plot(1:length(f_cos), fftshift(abs(fft(data_))))

figure(2)
plot(1:length(f_cos), fftshift(abs(fft(data_mod))))

v_t = zeros(1, (length(word)-1)*SpS);
for a=0:length(word)-1
    for b=1:SpS
        v_t(a*SpS+b) = word(a+1);
    end
end

save audio.rm v_t -ascii -double
