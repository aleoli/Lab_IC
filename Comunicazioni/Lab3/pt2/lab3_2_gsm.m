fc = 1e6;
NsBlock=1024;

Nblocks=100;

f_inizio = 925e6;  % downlink
f_fine = 960e6;

%f_inizio = 880e6;  % uplink
%f_fine = 915e6;

spettro = zeros(round(((f_fine-f_inizio)/fc)*NsBlock), 1);

conta = 0;

for f0 = f_inizio:fc:f_fine
    hRadio = comm.SDRRTLReceiver('CenterFrequency', f0, 'EnableTunerAGC', true, 'SamplesPerFrame', NsBlock, 'OutputDataType', 'single');
    
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

    tmp_2 = zeros(NsBlock, 1);
    for c = 0:(Nblocks-1)
        tmp = x_saved((c*NsBlock+1):((c+1)*NsBlock));
        tmp_2 = tmp_2 + abs(fft(tmp)).^2;
    end
    
    spettro((conta*NsBlock+1):((conta+1)*NsBlock)) = 10*log10(fftshift(tmp_2/Nblocks));
    
    conta = conta+1;
end

delta_f = (f_fine-f_inizio)/length(spettro);
ff = f_inizio:delta_f:(f_fine-delta_f);
figure(1)
plot(ff, spettro)

