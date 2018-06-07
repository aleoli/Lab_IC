CenterFrequency=92.1e6;
SampleRate=1e6;
NsBlock=1024;

Nblocks=1000;

hRadio = comm.SDRRTLReceiver('CenterFrequency', CenterFrequency, 'EnableTunerAGC', true, 'SamplesPerFrame', NsBlock, 'OutputDataType', 'single');

if ~isempty(sdrinfo(hRadio.RadioAddress))
    x_saved=NaN*ones(Nblocks*NsBlock,1);
    
    for Counter=1:Nblocks
        [x, len, lost(Counter)] = step(hRadio);
        x_saved((Counter-1)*NsBlock+1:(Counter-1)*NsBlock+NsBlock)=x;
    end
else
    warning('SDR Device not connected')
end

release(hRadio);


x_saved_fft = zeros(Nblocks*NsBlock,1);
tmp_2 = zeros(NsBlock);
for c = 0:(Nblocks-1)
    tmp = x_saved((c*NsBlock+1):((c+1)*NsBlock));
    x_saved_fft((c*NsBlock+1):((c+1)*NsBlock)) = abs(fft(tmp)).^2;
    tmp_2 = tmp_2 + x_saved_fft((c*NsBlock+1):((c+1)*NsBlock));
end

tmp_2 = tmp_2/Nblocks;

df = SampleRate/length(tmp_2);
ff = (CenterFrequency-SampleRate/2):df:(CenterFrequency+SampleRate/2-df);

figure(1)
plot(ff, 10*log(fftshift(tmp_2)))


df = SampleRate/length(x_saved);
ff = (CenterFrequency-SampleRate/2):df:(CenterFrequency+SampleRate/2-df);

figure(2)
plot(ff, 10*log(fftshift(fft(x_saved)).^2))

