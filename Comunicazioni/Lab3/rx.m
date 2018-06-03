Fc = 44100;
Tc = 1/Fc;
SpS = 100;

%in = load('audio.rm')';
in = load('testo.rm');

figure(1)
plot(1:length(in), fftshift(abs(fft(in))))

% demodulazione
f0 = 10000;
f_cos = cos(2*pi*f0*[0:Tc:(Tc*length(in) - Tc)]);
data_dem = f_cos .* in;

s_t = zeros(length(data_dem), 1);
for a=1:SpS
    s_t(a) = 1;
end
S_f = (fft(s_t));
H_rx = S_f;
X_f = fft(data_dem);
Y_f = H_rx' .* X_f;
y = ifft(Y_f);


figure(2)
plot(1:length(Y_f), fftshift(abs(Y_f)))


data = y(1:SpS:end) > 0.5;

% binario to decimale
n_simboli = length(data)/nbit;
index_out = zeros(1, n_simboli);
sig_out = zeros(1, n_simboli);
for a=1:n_simboli
    data(((a-1)*nbit+1):(a*nbit))
    index_out(a) = bi2de(data(((a-1)*nbit+1):(a*nbit)));
    sig_out(a) = codebook(index_out(a)+1);
end

char(sig_out)
