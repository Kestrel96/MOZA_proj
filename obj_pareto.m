function obj = obj_pareto(x)
%OBJ_FUN Summary of this function goes here
%   Detailed explanation goes here
out_ac=run_sim(x,"kask4_ac");
freq=out_ac.freq_vect;
Aac=out_ac.variable_mat(6,:);
fg=get_fg(Aac,freq);
ku=real(Aac(1));
b=boost(Aac);


obj(1)=-fg;
obj(2)=-ku;


 figure(2)
 semilogx(freq,real(Aac))
 ylim([-10 60])
 xline(fg,"--","Color",'blue')
 yline(real(Aac(1))-3,"--")
 xline(200e6,"--","Color",'green')
 legend("X","f_{g}")
 title("Wyniki w trakcie optymalizacji (Pareto)")
 xlabel("Częstotliwość [Hz]")
 ylabel("Wzmocnienie")

txt=sprintf("ku: %0.3f; fg:%e; b=%0.3f",ku,fg,b);
disp(txt);

end

