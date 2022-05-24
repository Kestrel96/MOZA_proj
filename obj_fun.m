function [GBW] = obj_fun(x)
%OBJ_FUN Funkcja celu.
%   Funckja obliczająca przeskalowaną wartość BGW (log(GBW)). Każde
%   wywołanie wymaga uruchomienia symulatora.
%   x - przeskalowany do właściwej postaci wektore parametrów
%   optymalizowanych

% Symulacja i pobranie wyników.
out_ac=run_sim(x,"kask4_ac");
freq=out_ac.freq_vect;
Aac=out_ac.variable_mat(6,:);
Aac=db(abs(Aac));

fg=get_fg(Aac,freq);% cz. graniczna
ku=Aac(1); %wzmocnienie @ 1kHz
b=boost(Aac); %podbicie (tylko poglądowo)

%drukowanie wykresów (jeśli potrzebne odkomentować)
 figure(2)
 semilogx(freq,abs(Aac))
 ylim([-10 60])
 xline(fg,"--","Color",'blue')
 yline(abs(Aac(1))-3,"--")
 xline(200e6,"--","Color",'green')
 legend("X","f_{g}")
 title("Wyniki w trakcie optymalizacji")
 xlabel("Częstotliwość [Hz]")
 ylabel("Wzmocnienie")


GBW=-log(ku*fg); %przeskalowany GBW
%wyświetlenie wartości otrzymanych z symulacji
txt=sprintf("Boost: %0.3f; fg:%e; ku=%0.3f, log(GBW) %e ",b,fg,abs(Aac(1)),GBW);
disp(txt);

end

