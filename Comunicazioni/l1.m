clear all
close all

%fc = 8e3;
%Tc = 1/fc;

%p0 = 1e-3;
%V = 8;

%N = 100;
%nbit = 8;
%sig = (rand(1, N)*2-1)*V;

%partition = (-1:(2/nbit):1)*V;

%index = quantiz(sig, partition);

%words = de2bi(index, nbit);
%outdata = bsc(words, p0);

%index_out = (bi2de(outdata)')-nbit/2;

%figure(1)
%plot(0:N-1, index)

%figure(2)
%plot(0:N-1, index_out)

%{figure(1)
%histogram(sig, 100, 'Normalization', 'pdf')

%sig;
%out_sign = index_out/(nbit/2)*V;

%figure(2)
%histogram(out_sign, 100, 'Normalization', 'pdf')%}




clear all
close all

fc = 8e3;
Tc = 1/fc;
B = 1/(2*Tc);

Npti=1e6;
nbit=6;
M=2^nbit;
V=1;
DeltaV=2*V/M;
pe=1e-5;

sig_in=2*rand(1,Npti)-1;
partition=[-V+DeltaV:DeltaV:V-DeltaV];
codebook=[-V+DeltaV/2:DeltaV:V-DeltaV/2];
[index,quants]=quantiz(sig_in,partition,codebook);

% figure;
% plot(sig_in(1:100));
% hold on
% plot(quants(1:100));

word=de2bi(index,nbit);
word_out=bsc(word,pe);

index_out=bi2de(word_out);
sig_out=codebook(index_out+1);
err=sig_out-sig_in;

histogram(sig_in, 100, 'Normalization', 'pdf')

figure(2)
d_f = fc/length(sig_out);
f = (-B/2):d_f:(B/2-d_f);
F = abs(fft(sig_out, length(f))).^2;

plot(f, fftshift(F))

N=var(err);
S=var(sig_in);

10*log10(S/N)

10*log10(M^2)
