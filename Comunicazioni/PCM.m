clear all
close all
Npti=1e5;
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

N=var(err)
S=var(sig_in)

10*log10(S/N)