clear all
close all

%fc = 8e3;
%Tc = 1/fc;

p0 = 1e-3;
V = 8;

N = 100;
nbit = 8;
sig = (rand(1, N)*2-1)*V;

partition = (-1:(2/nbit):1)*V;

index = quantiz(sig, partition);

words = de2bi(index, nbit);
outdata = bsc(words, p0);

index_out = (bi2de(outdata)')-nbit/2;

%figure(1)
%plot(0:N-1, index)

%figure(2)
%plot(0:N-1, index_out)

figure(1)
histogram(sig, 100, 'Normalization', 'pdf')

sig;
out_sign = index_out/(nbit/2)*V;

figure(2)
histogram(out_sign, 100, 'Normalization', 'pdf')

