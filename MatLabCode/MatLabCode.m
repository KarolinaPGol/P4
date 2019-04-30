[in2,Fs] = audioread('Elise.mp3');
in = in2(1:400000,1);

Ts = 1/Fs;
L = 0:Ts:1;
%L = L.';

%Getting min, max values
signalLength = length(in);
fRangeOfSignal =(0:signalLength-1)*(Fs/signalLength);

inTransformed = fft(in);
power = abs(inTransformed).^2/signalLength;    % power of the DFT

plot(fRangeOfSignal,power)
xlabel('Frequency')
ylabel('Power')

%Finding frequencies  that magnitude is > 0.25 (so they are relevant) /
%/ eliminating harmonics
relevantFrequencies = 69;
for n =1:round(signalLength/2) %we take first half of the values 
    
    if power(n) > 0.25
       relevantFrequencies = [relevantFrequencies, fRangeOfSignal(n)];
    end
end
relevantFrequencies=relevantFrequencies'; %transposing so its raw not clumn

%Finding how many distinguishible frequency there are
%it is done depending on how many seminotes there are
howManygroups=0;
for k = 1:length(relevantFrequencies)-1
    if ((relevantFrequencies(k+1)/relevantFrequencies(k)) <  -1.1) || ((relevantFrequencies(k+1)/relevantFrequencies(k)) > 1.2)
        howManygroups=howManygroups+1;
    end   
end

%Grouping into 5 frequency groups
[idx,soundFreq] = kmeans(relevantFrequencies,howManygroups);
soundFreq %printing the mean frequencies of those groups: ~ frequencies of the notes

%inTransformedMag = abs(inTransformed);
%plot(inTransformedMag)


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