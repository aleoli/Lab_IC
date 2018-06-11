clear all
close all

testo = 1;
if testo  
    Fs = 22050/2; %
    
    size = 0;
    FID = fopen('testo.txt');
    while (~feof(FID))
        riga = fgetl(FID);
        data((size+1):(size+length(riga))) = riga;
        size = size + length(riga) + 1;
        %data((size-1):size) = "\n";
    end
    fclose(FID);
    %data = compose(data);
    data = double(data);
else
    [data,Fs]=audioread('../../Lab1/Audio/KDE_Startup.wav');
    data=data(:,1)';
    sound(data, Fs);
    %save sound.rm data -ascii -double
end


V = max(abs(data)); %NORMALIZZAZIONE VALORI DA SCALA ASCII (255) A 1
nbit = 8;  %CAMPIONAMENTO SU 8 BIT. CON MENO BIT ALCUNI CARATTERI CADREBBERO NELLO STESSO INTERVALLO
M=2^nbit; %N livelli
DeltaV = 2*V/M;
Tc = 1/Fs;
SpS = 100;
Fc = Fs;
Rs = Fc/SpS;
%B = 1/(2*Tc);

%data_ = data*(1/V);

f0 = 10000;
f_cos = cos(2*pi*f0*[0:Tc:(Tc*length(data) - Tc)]);
data_mod = f_cos .* data;

partition=[-V+DeltaV:DeltaV:V-DeltaV];  %QUANTIZZAZIONE
codebook=[-V+DeltaV:DeltaV:V];
[index,quants]=quantiz(data,partition,codebook);
word=de2bi(index,nbit)';

clear size;
w_dim = size(word);
v_t = zeros(1, (w_dim(1))*(w_dim(2))*SpS);
for a=0:w_dim(2)-1
    for b=0:w_dim(1)-1
        %v_t(a*w_dim(1)+b+1) = word(b+1, a+1);
        for c=1:SpS
            v_t(a*w_dim(1)*SpS+b*SpS+c) = word(b+1, a+1);
        end
    end
end

figure(1)
plot(1:length(v_t), fftshift(abs(fft(v_t)).^2))

f0 = 10000; %A METà TRA 20 E 20000
f_cos = cos(2*pi*f0*[0:Tc:(Tc*length(v_t) - Tc)]);
v_t_mod = f_cos .* v_t;

figure(2)
plot(1:length(v_t_mod), fftshift(abs(fft(v_t_mod)).^2))

if testo
    save testo.rm v_t_mod -ascii -double %SALVO SEGNALE MODULATO
    testo_orig = v_t(1:SpS:end);
else
    audio_orig = data;
    save audio.rm v_t_mod -ascii -double
end
