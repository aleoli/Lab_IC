clear all
close all

testo = 0;
if testo
    Fs = 44100/2;
    
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
    
    % companding
    mu = 255;
    data = compand(data, mu, max(abs(data)), 'mu/compressor');
    
end


V = max(abs(data)); %NORMALIZZAZIONE VALORI DA SCALA ASCII (255) A 1
nbit = 8;  %CAMPIONAMENTO SU 8 BIT. CON MENO BIT ALCUNI CARATTERI CADREBBERO NELLO STESSO INTERVALLO
M=2^nbit; %N livelli
DeltaV = 2*V/M;
Tc = 1/Fs;
SpS = 5;
Fc = Fs;
Rs = Fc/SpS;
B = 1/(Tc);

%data_ = data*(1/V);

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

d_f = Fs/length(v_t);
f = (-B/2):d_f:(B/2-d_f);

figure(1)
plot(f, fftshift(abs(fft(v_t)).^2))

f0 = 10000; %A MET� TRA 20 E 20000
f_cos = cos(2*pi*f0*[0:Tc:(Tc*length(v_t) - Tc)]);
v_t_mod = f_cos .* v_t;

figure(2)
plot(f, fftshift(abs(fft(v_t_mod)).^2))

if testo
    %save testo.rm v_t_mod -ascii -double %SALVO SEGNALE MODULATO
    testo_orig = v_t(1:SpS:end);
    audiowrite('testo.wav', (v_t_mod+1)/2, Fs);
else
    audio_orig = v_t(1:SpS:end);
    %save audio.rm v_t_mod -ascii -double
    audiowrite('audio.wav', (v_t_mod+1)/2, Fs);
end
