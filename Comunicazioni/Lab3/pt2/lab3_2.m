fc = 1e5;
NsBlock=1024;

Nblocks=10;

spettro = zeros(((107.9e6-87.6e6)/fc)*NsBlock, 1);

conta = 0;

for f0 = 87.6e6:fc:107.9e6
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
        tmp_2 = tmp_2 + fft(tmp);
    end
    
    spettro((conta*NsBlock+1):((conta+1)*NsBlock)) = tmp_2/Nblocks;
    
    conta = conta+1;
end

delta_f = (107.9-87.6)/length(spettro);
ff = 87.6:delta_f:(107.9-delta_f);
figure(1)
plot(ff, spettro)

