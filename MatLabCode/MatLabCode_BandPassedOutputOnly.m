% 1. Taking an audio signal in form of the popular song
% 2. STEM analyzing it using external program to extract the melody of one instrument

fprintf('PROGRAM START \n');

[in2,Fs] = audioread('Elise.mp3');
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

BandPassedSignals = bandpass(in,[rangesStartingPoints(1) rangesStartingPoints(2)],Fs);
for j = 2:7
BandPassedSignals = [BandPassedSignals bandpass(in,[rangesStartingPoints(j) rangesStartingPoints(j+1)],Fs)];
end

%5. PITCH SHIFTING

%5.a Finding a mean of fundamental frequencies of a signal
CellsWithSignalsFundamentalFreq = cell(7,1);
meanFreq = zeros(1,7);

%sinWaves = cell(1,7);

for jj = 1:7
CellsWithSignalsFundamentalFreq{jj} = pitch(BandPassedSignals(:,jj), Fs);
meanFreq(jj) = mean(CellsWithSignalsFundamentalFreq{jj});
end

%5.b Shifting all the frequencies if the highest of them is above 700Hz
pitchShiftedSignals = zeros(signalLength,7);

if max(meanFreq) > 700 
   fprintf('Maximum frequency value is higher then 700 \n');
   fprintf('Starting pitch shifting procedure \n');
   semitones = -round(max(meanFreq)/700); 
   %we have to do it that way, the ratio between max(meanFreq)/700 will tell us how
   %many semitones we have to shift our song   
   for jj = 1:7
       
       pitchShiftedSignals(:,jj) = pitchShifter(BandPassedSignals(:,jj),Fs,semitones);
       
   end   

% 6. EXPORTING 7 AUDIO FILES   

fprintf('Exporting pitch shifted files \n');

matrixSignalsPS = pitchShiftedSignals(:,1);
for i=2:7
    
   matrixSignalsPS = [matrixSignalsPS pitchShiftedSignals(:,i)];
    
end 

matrixSignals = [matrixSignals zeros(signalLength,1)];

audiowrite('outputFiles/8channels.wav',matrixSignalsPS,Fs)

fprintf('Exporting pitch shifted files DONE \n');

else 

fprintf('Exporting band-passed files \n');

matrixSignals = BandPassedSignals(:,1);
for i=2:7
    
   matrixSignals = [matrixSignals BandPassedSignals(:,i)];
    
end 

matrixSignals = [matrixSignals zeros(signalLength,1)];

audiowrite('outputFiles/8channels.wav',matrixSignals,Fs)

fprintf('Exporting band-passed files DONE \n');

 end %if-else end

fprintf('PROGRAM DONE \n')
