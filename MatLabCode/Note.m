%playNote code written for various purposes
function a = Note(amplitude, frequency , duration)

Fs = 44100;


Ts = 1/Fs; % sampling period
t=[0:Ts:duration];
a=amplitude*sin(2*pi*frequency*t);
a= a';
%plot(a(1:400))



end
    


