function [GBW] = obj_fun(x)
%OBJ_FUN Summary of this function goes here
%   Detailed explanation goes here
out_ac=run_sim(x,"kask4_ac");
freq=out_ac.freq_vect;
Aac=out_ac.variable_mat(6,:);
Aac=db(abs(Aac));
fg=get_fg(Aac,freq);
b=boost(Aac);





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



GBW=-abs(Aac(1))*fg/10e8;
txt=sprintf("Boost: %0.3f; fg:%e; ku=%0.3f, log(GBW) %e ",b,fg,abs(Aac(1)),GBW);


disp(txt);

end

