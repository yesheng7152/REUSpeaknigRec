% converting audio to spectrogram 
file='4_chen1.ogg';
[y,fs]=audioread(file);
leftchannel=y(:,1);
%rightchannel=y(:,2);
nfft=1024;
noverlap=200;
window=10000;

%spectrogram(leftchannel,window,noverlap,nfft,fs,'yaxis');
spectrogram(leftchannel,hanning(900),noverlap,nfft,fs,'yaxis');
melSpectrogram(y,fs,'FrequencyRange');