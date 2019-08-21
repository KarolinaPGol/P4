function [soundFreq] = soundFrequenciesFunction(in, Fs)
%GETTING MIN, MAX VALUES
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
relevantFrequencies = 0;
for n =1:round(signalLength/2) %we take first half of the values because thats how it works
    
    if power(n) > 0.25
       relevantFrequencies = [relevantFrequencies, fRangeOfSignal(n)];
    end
end
relevantFrequencies=relevantFrequencies'; %transposing so its raw not column

%3. Finding how many different notes there are
%it is done depending on how many semitones there are
sort(relevantFrequencies);  %-------------------NEW
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
end 