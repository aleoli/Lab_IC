Fc = 44100/2;
Tc = 1/Fc;

if testo
    %in = load('testo.rm');
    [in,Fs] = audioread('testo.wav');
    in = (in*2 - 1)';
else
    [in,Fs] = audioread('audio.wav');
    in = (in*2 - 1)';
end

d_f = Fs/length(in);
f = (-B/2):d_f:(B/2-d_f);

figure(1)
plot(f, fftshift(abs(fft(in)).^2))

% demodulazione
f0 = 10000;
f_cos = cos(2*pi*f0*[0:Tc:(Tc*length(in) - Tc)]);
data_dem = f_cos .* in;

figure(2)
plot(f, fftshift(abs(fft(data_dem)).^2))

s_t = zeros(length(data_dem), 1);
for a=1:SpS
    s_t(a) = 1;
end
S_f = (fft(s_t));
H_rx = S_f;
X_f = fft(data_dem);
Y_f = H_rx' .* X_f;
y = ifft(Y_f);


figure(3)
plot(f, fftshift(abs(Y_f).^2))

%if testo
    % dal diagramma ad occhio si vede che bisogna campionare sul primo bit
    eyediagram(y(1:2000*SpS), 2*SpS, 2*SpS);
%end

data = y(1:SpS:end) > 0.5; %SOGLIA

% binario to decimale
n_simboli = length(data)/nbit;
index_out = zeros(1, n_simboli);
sig_out = zeros(1, n_simboli);
for a=1:n_simboli
    index_out(a) = bi2de(data(((a-1)*nbit+1):(a*nbit)));
    sig_out(a) = codebook(index_out(a)+1);
end

if testo
    char(sig_out)
    err = testo_orig - data;
else
    
    % companding
    sig_out = compand(sig_out, mu, max(abs(data)), 'mu/expander');
    
    sound(sig_out, Fc);
    err = audio_orig - data;
end

errors = sum(err)
