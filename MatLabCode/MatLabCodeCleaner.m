[in2,Fs] = audioread('Elise.mp3');
in = in2(1:400000,1); %cutting the signal so its shorter 

Ts = 1/Fs;
L = 0:Ts:1;
%L = L.';

%Calling a custom function that finds frequencies of the notes
[soundFreq] = soundFrequenciesFunction(in, Fs);

%5. Finding the biggest frequency value of the note
Fmax = max(soundFreq);


%PITCH SHIFTING
%%semitones = 1;   %it cant be 0 because some errors pop  

%if the song has too high frequency shift the whole thing down
if Fmax > 700
   semitones = -round(Fmax/700)  %the same as    FrequencyOfSong = Fmax-700.
   %we have to do it that way, the ratio between Fmax/700 will tell us how
   %many semitones we have to shift our song
   [out] = pitchShifter(in,Fs,semitones);
   sound(out,Fs);
end













%Code that i removed:
%groupedFrequencies = 69;
%if (((relevantFrequencies(k+1)/relevantFrequencies(k)) <  -1.1) && ((relevantFrequencies(k+1)/relevantFrequencies(k)) > 0)) || (((relevantFrequencies(k+1)/relevantFrequencies(k)) < 0.0) && ((relevantFrequencies(k+1)/relevantFrequencies(k)) > 1.2))
%((relevantFrequencies(k+1)/relevantFrequencies(k)) < 0.9) || ((relevantFrequencies(k+1)/relevantFrequencies(k)) > 1.2) || ((relevantFrequencies(k+1)/relevantFrequencies(k)) > -0.9) || ((relevantFrequencies(k+1)/relevantFrequencies(k)) < -1.2)