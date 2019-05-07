% 1. Taking an audio signal in form of the popular song
% 2. STEM analyzing it using external program to extract the melody of one instrument

[in,Fs] = audioread('Elise.mp3');
in = in2(1:400000,1); %cutting the signal so its shorter, for testing purposes

signalLength = length(in);
Ts = 1/Fs;
L = 0:Ts:1;


%3. FINDING THE FREQUENCY OF THE LOWEST AND HIGHEST NOTES
%What is it all about:
%Problem was that there is no maximum value of frequency because there are
%infinate numbers of overtones. What I wanted to do here is to eliminate
%all of them and only leave the loud, sharp piano key sounds. Then we're
%finding those key sound's frequencies.

%3.a Calling a custom function that finds frequencies of the notes
[soundFreq] = soundFrequenciesFunction(in, Fs);

%3.b Finding the biggest and smallest frequency value of the note
Fmax = max(soundFreq);
Fmin = min(soundFreq);

%4. APPLYING BAND-PASS FILTER AND DIVIDING TO 7 RANGES
distance = (Fmax-Fmin)/7; %distance between 7 ranges

%4.a Saving Starting points of the ranges in the rangesStartingPoints array
%So the starting point will be rangesStartingPoints(1) or Fmin 
%and the ending point will be rangesStartingPoints(8) or Fmax
rangesStartingPoints = Fmin;
for i = 1:7
rangesStartingPoints = [rangesStartingPoints, Fmin+i*distance];
end
rangesStartingPoints

%4.b Storing band-passed signals in the cell array
CellsWithSignals = cell(7,1);
for j = 1:7
CellsWithSignals{j} = bandpass(in,[rangesStartingPoints(j) rangesStartingPoints(j+1)],Fs);
end


% %?. PITCH SHIFTING
% %%semitones = 1;   %it cant be 0 because some errors pop  
% 
% %if the song has too high frequency shift the whole thing down
% if Fmax > 700
%    semitones = -round(Fmax/700)  %the same as    FrequencyOfSong = Fmax-700.
%    %we have to do it that way, the ratio between Fmax/700 will tell us how
%    %many semitones we have to shift our song
%    [out] = pitchShifter(in,Fs,semitones);
%    sound(out,Fs);
% end

%5. CREATING SINE WAVE FOR EACH OF THE 7 RANGES

%5.a Finding a mean of fundamental frequencies of a signal
CellsSignalsFF = cell(7,1);
meanFreq = zeros(1,7);

sinWaves = cell(1,7);
for jj = 1:7
CellsSignalsFF{jj} = pitch(CellsWithSignals{jj}, Fs);
meanFreq(jj) = mean(CellsSignalsFF{jj});

%6. PITCH SHIFTING
%shift all the frequencies if the highest of them is above 700Hz
if max(meanFreq) > 700 
    shift = Fmax-700;
    meanFreq = meanFreq - shift;
    for kk = 1:7
        %making sure no value is below 0
        if meanFreq(kk) <0
            meanFreq(kk) = 0;
        end
    end
end

%7. CREATING A SINE WAVE SIGNALS
sinWaves{jj} = sin(2*pi*meanFreq(jj)*L);
end

% sound(sinWaves{1})

%8. EXPORTING THE SINE WAVES AS A 7 AUDIO FILES
audiowrite('outputFiles/bp1.wav',sinWaves{1},Fs)
audiowrite('outputFiles/bp2.wav',sinWaves{2},Fs)
audiowrite('outputFiles/bp3.wav',sinWaves{3},Fs)
audiowrite('outputFiles/bp4.wav',sinWaves{4},Fs)
audiowrite('outputFiles/bp5.wav',sinWaves{5},Fs)
audiowrite('outputFiles/bp6.wav',sinWaves{6},Fs)
audiowrite('outputFiles/bp7.wav',sinWaves{7},Fs)

