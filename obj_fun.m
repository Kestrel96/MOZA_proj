function [GBW] = obj_fun(x)
%OBJ_FUN Summary of this function goes here
%   Detailed explanation goes here
out_ac=run_sim(x,"kask4_ac");
freq=out_ac.freq_vect;
Aac=out_ac.variable_mat(6,:);
fg=get_fg(Aac,freq);
b=boost(Aac);





 figure(2)
 semilogx(freq,real(Aac))
 ylim([-10 60])
 xline(fg,"--","Color",'blue')
 yline(real(Aac(1))-3,"--")
 xline(200e6,"--","Color",'green')
 legend("X","f_{g}")
 title("Wyniki w trakcie optymalizacji")
 xlabel("Częstotliwość [Hz]")
 ylabel("Wzmocnienie")

GBW=-real(Aac(1))*fg;
txt=sprintf("Boost: %0.3f; fg:%e; GBW= %e ",b,fg,GBW);
disp(txt);

end

