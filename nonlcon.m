function [c,ceq] = nonlcon(x)
%NONLCON Summary of this function goes here
%   Detailed explanation goes here


out_ac=run_sim(x,"kask4_ac");
Aac=out_ac.variable_mat(6,:);
freq=out_ac.freq_vect;
b=boost(Aac);
fg=get_fg(Aac,freq);
ku=abs(Aac(1));
fgmin=200e6;
kumin=20;
bmax=1;
c(1)=-(fg/fgmin-1);
c(2)=-(ku/kumin-1);
c(3)=(b-bmax);


ceq = [];
end

