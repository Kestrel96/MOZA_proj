function [c,ceq] = nonlcon(x)
%NONLCON Nierównościowe ograniczenia dla zadania optymalizacji.
%   Ogranicznenia nierównościowe na fg, ku i podbicie.
%   x - przeskalowany do właściwej postaci wektore parametrów
%   optymalizowanych

%symulacja i pobranie danych
out_ac=run_sim(x,"kask4_ac");
Aac=out_ac.variable_mat(6,:);
freq=out_ac.freq_vect;
%obliczenie parametrów potrzebnych dla ograniczeń:
b=boost(Aac); %podbicie
fg=get_fg(Aac,freq);%f graniczna
ku=abs(Aac(1));%wzmocnienie
%minimalne i mksymalne dopuszczalne parametry
fgmin=200e6;
kumin=20;
bmax=1;

%wektor ograniczeń (c=<0)
c(1)=-(fg/fgmin-1);
c(2)=-(ku/kumin-1);
c(3)=(b-bmax);


ceq = [];
end

