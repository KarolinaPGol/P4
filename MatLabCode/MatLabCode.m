[in2,Fs] = audioread('Elise.mp3');
in = in2(1:400000,1); %cutting the signal so its shorter 

Ts = 1/Fs;
L = 0:Ts:1;
%L = L.';



%GETTING MIN, MAX VALUES (longass code)
%What is it all about:
%Problem was that there is no maximum value of frequency because there are
%infinate numbers of overtones. What I wanted to do here is to eliminate
%all of them and only leave the loud, sharp piano key sounds. Then we're
%finding those key sound's frequencies.

%1. Fast fourier transform
signalLength = length(in);
fRangeOfSignal =(0:signalLength-1)*(Fs/signalLength);

inTransformed = fft(in);
power = abs(inTransformed).^2/signalLength;    % power of the DFT

plot(fRangeOfSignal,power)
xlabel('Frequency')
ylabel('Power')

%2.Finding frequencies  that magnitude is > 0.25 (so they are relevant) /
%/ eliminating harmonics
relevantFrequencies = 69;
for n =1:round(signalLength/2) %we take first half of the values 
    
    if power(n) > 0.25
       relevantFrequencies = [relevantFrequencies, fRangeOfSignal(n)];
    end
end
relevantFrequencies=relevantFrequencies'; %transposing so its raw not clumn

%3. Finding how many different notes there are
%it is done depending on how many seminotes there are
howManygroups=0;
for k = 1:length(relevantFrequencies)-1
    if ((relevantFrequencies(k+1)/relevantFrequencies(k)) <  -1.1) || ((relevantFrequencies(k+1)/relevantFrequencies(k)) > 1.2)
        howManygroups=howManygroups+1;
    end   
end

%4. Grouping into 4 (=howManygroups) frequency groups
[idx,soundFreq] = kmeans(relevantFrequencies,howManygroups);
soundFreq %printing the mean frequencies of those groups: ~ frequencies of the notes

%inTransformedMag = abs(inTransformed);
%plot(inTransformedMag)

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