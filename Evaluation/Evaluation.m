excel_file = readtable('LikertOnly.xlsx');

% Scenario A & B combined
Visual = table2array(excel_file(:,1:12));
Vibrations = table2array(excel_file(:,13:20));
Overall = table2array(excel_file(:,21:30));

% %Mean of every question
% for i=1:
%     
%     r1 = mean(A(:,i)); %mean
%     sqrt( (sum((A(:,i) - r1(:)).^2)/ m) ); %standard deviation
%    
%     subplot
%     barplot(i);
%     text
%     
% end

%Histograms for each question and each group
figure(1)
for i=1:12
   subplot(2,12,i) %command for making many diagrams subplot(rows,columns,plots)
   histogram(Visual(:,i))
   textual_number=num2str(i); %converting number into String
   text = strcat('Q',textual_number);
   xlabel(text);
end

figure(2)
for i=1:8
   subplot(1,8,i) %command for making many diagrams subplot(rows,columns,plots)
   histogram(Vibrations(:,i))
   textual_number=num2str(i); %converting number into String
   text = strcat('Q',textual_number);
   xlabel(text);
end


figure(3)
for i=1:10
   subplot(2,10,i) %command for making many diagrams subplot(rows,columns,plots)
   histogram(Overall(:,i))
   textual_number=num2str(i); %converting number into String
   text = strcat('Q',textual_number);
   xlabel(text);
end

% Cronbachs alfa
VisualNeg = [1,4,6,8,10,11,12];
VibrationsNeg = [2,3,5,7];  
OverallNeg = [1,4,5,8,9,10];

Visual(:,VisualNeg) = 5-Visual(:,VisualNeg); %(all rows, columns negative questions) = and we change them with 5-element value
Vibrations(:,VibrationsNeg) = 5-Vibrations(:,VibrationsNeg);
Overall(:,OverallNeg) = 5-Overall(:,OverallNeg);

VisualC_all = cronbach(Visual)
VibrationsC_all = cronbach(Vibrations)
OverallC_all = cronbach(Overall)



%Unused:
%thats if we take 2 grups of two scenarios:
%A = Scenario A - Rick Atley, Fur Elise
%B = Scenario B - Dr Dre, Poker Face
% AVisual = table2array(excel_file(1:15,1:12));
% BVisual = table2array(excel_file(16:30,1:12));
% 
% AVibrations = table2array(excel_file(1:15,13:20));
% BVibrations = table2array(excel_file(16:30,13:20));
% 
% AOverall = table2array(excel_file(1:15,21:30));
% BOverall = table2array(excel_file(16:30,21:30));

% VisualNeg = [1,4,6,8,10,11,12];
% VibrationsNeg = [14,15,17,19];
% OverallNeg = [21,24,25,28,29,30];


