%% starting point results
clear
%----------
%x0=[15 8 15 20 230 120 270];

%-----------------
%close all;
x0=[25 20 15 100 230 135 370];
%x0=[10 80 150 500 100 50 50];

out_ac=run_sim(x0,"kask4_ac");
freq_0=out_ac.freq_vect;
Aac_0=out_ac.variable_mat(6,:);
fg_0=get_fg(Aac_0,freq_0);
GBW=Aac_0(1)*fg_0;
b=boost(Aac_0);

figure(1)
semilogx(freq_0,real(Aac_0))
ylim([-10 50])
xline(fg_0,"--","Color",'blue')
yline(real(Aac_0(1))-3,"--")
xline(200e6,"Color",'green','Label',"200MHz")
legend("X_0","f_{g0}")
title("Wyniki w punkcie początkowym")
xlabel("Częstotliwość [Hz]")
ylabel("Wzmocnienie")



%% scale
x2xs=@ (xs) xs./x0;
xs2x=@ (x) x.*x0;
%% bounds
lb=[0.1 0.1 0.1 0.1 0.1 0.1 0.1]; ub=[10 10 10 10 10 10 10];

%% optimize
fun=@(xs) obj_fun(xs2x(xs));
constr=@(xs) nonlcon(xs2x(xs));
opts=optimoptions('fmincon','Display','iter-detailed','PlotFcn',{'optimplotfval','optimplotx'},'FinDiffRelStep',1e-3);
x_opt=fmincon(fun,x2xs(x0),[],[],[],[],lb,ub,constr,opts);

%% compare results
close all;
out_ac=run_sim(xs2x(x_opt),"kask4_ac");
freq=out_ac.freq_vect;
Aac=out_ac.variable_mat(6,:);
fg=get_fg(Aac,freq);

figure(3)
semilogx(freq_0,real(Aac_0),'Color','blue')
xline(fg_0,"--","Color",'blue')
yline(real(Aac_0(1))-3,"--")
hold on
semilogx(freq,real(Aac),'Color','red');
xline(fg,"--","Color",'red')
xline(200e6,"Color",'green','Label',"200 MHz")
yline(real(Aac(1))-3,"--")
legend("X_0","f_{g0}")
title("Porównanie wyników w pkt. początkowym i optymalnym")
xlabel("Częstotliwość [Hz]")
ylabel("Wzmocnienie")

%% Pareto

fun=@(xs) obj_pareto(xs2x(xs));
p_constr=@(xs) pareto_constr(xs2x(xs));
opts=optimoptions('paretosearch','Display','iter','PlotFcn',{'psplotparetof'},'InitialPoints',x2xs(x0));
x_pareto=paretosearch(fun,7,[],[],[],[],lb,ub,p_constr,opts);

