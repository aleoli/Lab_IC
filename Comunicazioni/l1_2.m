clear all
close all

[data,Fs]=audioread('Audio/Sinfonia n. 5 (Beethoven) Il Destino bussa alla porta.mp3');
data=data(:,1)';

V = max(abs(data));
nbit=6;
M=2^nbit;
DeltaV=2*V/M;
pe=1e-5;
Tc = 1/Fs;
B = 1/(2*Tc);

data_ = data*(1/V);

partition=[-V+DeltaV:DeltaV:V-DeltaV];
codebook=[-V+DeltaV/2:DeltaV:V-DeltaV/2];
[index,quants]=quantiz(data_,partition,codebook);

word=de2bi(index,nbit);
word_out=bsc(word,pe);

index_out=bi2de(word_out);
sig_out=codebook(index_out+1);
err=sig_out-data_;

figure;
%data_ = data*(1/V);
histogram(data_, 100, 'Normalization', 'pdf')

figure(2)
d_f = Fs/length(data_);
f = (-B/2):d_f:(B/2-d_f);
F = abs(fft(data_, length(f))).^2;

plot(f, fftshift(F))


N=var(err)
S=var(data_)

10*log10(S/N)

10*log10((3*M^2)/(V^2)*S)

10*log10(M^2)


%figure;
%plot(t,data(:,1));

%figure;
%histogram(data(:,1),200,'Normalization','probability');

%F=(1/length(data(:,1))^2)*(abs(fftshift(fft(data(:,1)))).^2);

%figure;
%df=Fs/length(data);
%f=[-Fs/2:df:Fs/2-df];
%plot(f,10*log10(F));
%hold on;
%xlabel('Hz')
%ylabel('PSD')

