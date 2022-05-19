function obj = obj_pareto(x)
%OBJ_FUN Summary of this function goes here
%   Detailed explanation goes here
out_ac=run_sim(x,"kask4_ac");
freq=out_ac.freq_vect;
Aac=out_ac.variable_mat(6,:);
Aac=db(abs(Aac));
fg=get_fg(Aac,freq);
ku=abs(Aac(1));
b=boost(Aac);


obj(1)=-log(fg);
obj(2)=-ku;


 figure(2)
 semilogx(freq,abs(Aac))
 ylim([-10 60])
 xline(fg,"--","Color",'blue')
 yline(abs(Aac(1))-3,"--")
 xline(200e6,"--","Color",'green')
 legend("X","f_{g}")
 title("Wyniki w trakcie optymalizacji (Pareto)")
 xlabel("Częstotliwość [Hz]")
 ylabel("Wzmocnienie")
 
 

txt=sprintf("ku: %0.3f; log(fg):%e; b=%0.3f",ku,fg,b);
disp(txt);

end

