% 1. IMPORTING THE SONG
fprintf('PROGRAM START \n');

[in,Fs] = audioread('Cut2_abba.mp3');
%in = in2(1:800000,1); %cutting the signal so its shorter, for testing purposes

signalLength = length(in);
Ts = 1/Fs;
L = 0:Ts:1;


%2. FINDING THE FREQUENCY OF THE HIGHEST NOTE
%What is it all about:
%Problem was that there is no maximum value of frequency because there are
%infinate numbers of overtones. What I wanted to do here is to eliminate
%all of them and only leave the loud, sharp piano key sounds. Then we're
%finding those key sound's frequencies.

%2.a Calling a custom function that finds frequencies of the notes
[soundFreq] = soundFrequenciesFunction(in, Fs);

%2.b Finding the biggest and smallest frequency value of the note
Fmax = max(soundFreq);

%3. PITCH SHIFTING
% Pitch shifting so no fundamental freq is above 450 Hz

   fprintf('Starting pitch shifting procedure \n');
   semitones = -round(Fmax/450); 
   %we have to do it that way, the ratio between max(meanFreq)/450 will tell us how
   %many semitones we have to shift our song   

   in = pitchShifter(in,Fs,semitones);

%4. DIVIDING THE SIGNAL INTO 7 FREQUENCY BANDS
fprintf('Starting band-pass procedure \n');
BandPassedSignal = zeros(signalLength,7);
BandPassedSignals(:,1) = bandpass(in,[32 48],Fs);
BandPassedSignals(:,2) = bandpass(in,[49 72],Fs);
BandPassedSignals(:,3) = bandpass(in,[73 108],Fs);
BandPassedSignals(:,4) = bandpass(in,[109 162],Fs);
BandPassedSignals(:,5) = bandpass(in,[163 243],Fs);
BandPassedSignals(:,6) = bandpass(in,[244 365],Fs);
BandPassedSignals(:,7) = bandpass(in,[366 450],Fs);

%5. EQUALISING AMPLITUDES 
% Some frequency ranges are more detectable by human receptors
% Also 500Hz is resonance of a transducer but it's out of our range
% Amplitude of 32Hz - 48Hz has to be reduced 1.3 times 
% Amplitude of 48Hz - 72Hz has to be reduced 1.2 times 
% Amplitude of 72Hz - 108Hz has to be reduced 1.1 times 

BandPassedSignals(:,1) = BandPassedSignals(:,1)./1.3;
BandPassedSignals(:,2) = BandPassedSignals(:,2)./1.2;
BandPassedSignals(:,3) = BandPassedSignals(:,3)./1.1;


%6. EXPORTING TO .WAV FILE  

fprintf('Exporting to file \n');

matrixSignals = BandPassedSignals(:,1);
for i=2:7
    
   matrixSignals = [matrixSignals BandPassedSignals(:,i)];
    
end 

%Adding one column of zeros
matrixSignals = [matrixSignals zeros(signalLength,1)];

audiowrite('outputFiles/8channels_abba2.wav',matrixSignals,Fs)

fprintf('Exporting file DONE \n');

