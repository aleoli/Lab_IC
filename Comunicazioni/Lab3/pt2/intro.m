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
    tmp = real(x_saved((c*NsBlock+1):((c+1)*NsBlock)));
    x_saved_fft((c*NsBlock+1):((c+1)*NsBlock)) = fft(tmp);
    tmp_2 = tmp_2 + x_saved_fft((c*NsBlock+1):((c+1)*NsBlock));
end

tmp_2 = tmp_2/Nblocks;

figure(1)
plot(1:length(tmp_2), fftshift(tmp_2))

figure(2)
plot(1:length(x_saved), fftshift(fft(x_saved)))

