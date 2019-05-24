
[in2,Fs] = audioread('Elise.mp3');
in = in2(1:400000,1); %cutting the signal so its shorter 


bp = bandpass(in,[300 500],Fs);

signalLength = length(in);
fRangeOfSignal =(0:signalLength-1)*(Fs/signalLength);

%fft transform on input signal
inTransformed = fft(in);
power = abs(inTransformed).^2/signalLength;    % power of the DFT

%fft on band passed signal
bpTransformed = fft(bp);
powerBp = abs(bpTransformed).^2/signalLength;

subplot(1,2,1);
plot(fRangeOfSignal,power)
xlabel('Frequency')
ylabel('Power')

subplot(1,2,2);
plot(fRangeOfSignal,powerBp)
xlabel('Frequency')
ylabel('Power')