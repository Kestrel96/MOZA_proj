function [fg,ku,b] = get_working_params(x)
%GET_WORKING_PARAMS Summary of this function goes here
%   Detailed explanation goes here
% Symulacja i pobranie wyników.
out_ac=run_sim(x,"kask4_ac");
freq=out_ac.freq_vect;
Aac=out_ac.variable_mat(6,:);
Aac=db(abs(Aac));


%drukowanie wykresów (jeśli potrzebne odkomentować)
        %  figure(2)
        %  semilogx(freq,abs(Aac))
        %  ylim([-10 60])
        %  xline(fg,"--","Color",'blue')
        %  yline(abs(Aac(1))-3,"--")
        %  xline(200e6,"--","Color",'green')
        %  legend("X","f_{g}")
        %  title("Wyniki w trakcie optymalizacji")
        %  xlabel("Częstotliwość [Hz]")
        %  ylabel("Wzmocnienie")

fg=get_fg(Aac,freq);% cz. graniczna
ku=Aac(1); %wzmocnienie @ 1kHz
b=boost(freq,Aac); %podbicie (tylko poglądowo)
end

