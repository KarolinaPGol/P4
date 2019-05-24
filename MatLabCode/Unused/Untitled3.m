[in2,Fs] = audioread('Elise.mp3');


Ts = 1/Fs;
L = 0:Ts:1;
L = L.';
in = in2(1:400000,1);
L = length(in);

%value of semitones up, one semtone
semitones = 3;     

[out] = pitchShifter(in,Fs,semitones);
sound(out,Fs);