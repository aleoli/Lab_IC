clear all;
close all;
clc;

CenterFrequency=92.1e6;
SampleRate=1e6;
NsBlock=1024;

Nblocks=1000;

hRadio = comm.SDRRTLReceiver('CenterFrequency', CenterFrequency, ...
  'SampleRate', SampleRate, ...
  'EnableTunerAGC', true, ...
  'SamplesPerFrame', NsBlock, ...
  'OutputDataType', 'single');

if ~isempty(sdrinfo(hRadio.RadioAddress)) 
    
    x_saved=NaN*ones(Nblocks*NsBlock,1); 
    
    for Counter=1:Nblocks
        
        [x, len,lost(Counter)] = step(hRadio);
        
        x_saved((Counter-1)*NsBlock+1:(Counter-1)*NsBlock+NsBlock)=x;
        
    end
    
else
    warning('SDR Device not connected')
end
release(hRadio);