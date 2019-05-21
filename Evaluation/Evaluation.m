%[num,txt,raw] = xlsread('myfile') ;

excel_file = readtable('LikertOnly.xlsx');

%A = Scenario A - Rick Atley, Fur Elise
%B = Scenario B - Dr Dre, Poker Face

AVisual = table2array(excel_file(1:15,1:12));
BVisual = table2array(excel_file(16:30,1:12));

AVibrations = table2array(excel_file(1:15,13:20));
BVibrations = table2array(excel_file(16:30,13:20));

AOverall = table2array(excel_file(1:15,21:30));
BOverall = table2array(excel_file(16:30,21:30));

%Mean of every question
for i=1:
    
    r1 = mean(A(:,i)); %mean
    sqrt( (sum((A(:,i) - r1(:)).^2)/ m) ); %standard deviation
   
    subplot
    barplot(i);
    text
    
end

figure(1)
for i=1:10
   subplot(2,6,i) %command for making many diagrams subplot(rows,columns,plots)
   histogram(B(:,i))
   textual_number=num2str(i); %converting number into String
   text = strcat('Q',textual_number);
   xlabel(text);
end

