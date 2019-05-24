
array = [1 2 3; 4 5 6];
temp = zeros(2,3);
for jj = 1:3
% CellsSignalsFF{jj} = pitch(BandPassedSignals(:,jj), Fs);
% meanFreq(jj) = mean(CellsSignalsFF{jj});

temp(:,jj) = array(:,jj);
end