

frequency1 = 440;
frequency2 = 300;

note1 = Note(1,frequency1,1);
note2 = [ zeros(8001,1); Note(1,frequency2,1) ];

bandStarts = [32 48 72 108 162 243 365];
BandSignal = zeros(8001, 7);

for i=1:6
    if frequency1 > bandStarts(i) && frequency1 < bandStarts(i+1)
       BandSignal(:,i) = note1(:,1);
    end
    
    if frequency2 > bandStarts(i) && frequency2 < bandStarts(i+1)
        BandSignal(:,i) = [ BandSignal(:,i) ; note2(:,1) ];
    end   
%         if mean(BandSignal(:,i)) ~= 0       %if this band is already filled with note1, add note2 to it
%             BandSignal(:,i) = [BandSignal(:,i) ; note2(:,1)];
%         else
%             BandSignal(:,i) = note2(:,1);
%         end
 
end

if frequency1 > bandStarts(6)
    BandSignal(:,7) = note1(:,1);
end

if frequency2 > bandStarts(6)
    BandSignal(:,7) = [BandSignal(:,7) ; note2(:,1)];
%    if mean(BandSignal(:,7)) ~= 0       %if this band is already filled with note1, add note2 to it
%             BandSignal(:,7) = [BandSignal(:,6) ; note2(:,1)];
%    else
%             BandSignal(:,7) = note2(:,1);
%    end 
end    


% 7. EXPORTING TO FILE   
fprintf('Exporting to file \n');

matrixSignals = BandSignal(:,1);
for i=2:7
    
   matrixSignals = [matrixSignals BandSignal(:,i)];
    
end 

%Adding one column of zeros
matrixSignals = [matrixSignals zeros(signalLength,1)];

%audiowrite('outputFiles/interval.wav',matrixSignals,Fs)

fprintf('Exporting file DONE \n');