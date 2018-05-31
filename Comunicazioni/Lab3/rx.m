Fc = 44100;
Tc = 1/Fc;
SpS = 100;

in = load('audio.rm')';
data = in(SpS:SpS:end) > 0.5;

% binario to decimale
index_out=bi2de(data);
sig_out=codebook(index_out+1) * V;

% demodulazione
f0 = 10000;
f_cos = cos(2*pi*f0*[0:Tc:(Tc*length(sig_out) - Tc)]);
data_dem = f_cos .* sig_out;


s_t = zeros(length(data_dem), 1);
for a=1:SpS
    s_t(a) = 1;
end
S_f = (fft(s_t));
H_rx = S_f;
X_f = fft(data_dem);
Y_f = H_rx .* X_f;
y = ifft(Y_f);

