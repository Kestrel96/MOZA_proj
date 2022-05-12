function [c,ceq] = nonlcon(x)
%NONLCON Summary of this function goes here
%   Detailed explanation goes here


out_ac=run_sim(x,"kask4_ac");
Aac=out_ac.variable_mat(6,:);
freq=out_ac.freq_vect;
b=boost(Aac);
fg=get_fg(Aac,freq);

c(1)=1-b;
%c(2)=Aac(1)-1;
c(2)=fg-200e6;
ceq = [];
end

