%% starting point results
clear
close all;
%-----------------
%x0=[25 20 15 100 230 135 370];
%x0=[20.8297483895642,0.200000000000000,22.5000000000000,125,230,135,370]
%x0=[15 8 15 20 230 120 270];
%x0=[39     2    23   268   358   210   688];
%x0=[45 20 23 220 320 210 700];
%points from pareto set
%x0=[28.9229848492032,2,42.1878297848572,240.181815596788,370.303749261561,241.111417620530,997.688499801257];
%best point from pareto
x0=[41.7679147209104,0.0751112681817843,56.0812946983207,383.446514581162,302.534925272885,206.660424139118,1893.50663464421]
%pareto again (best so far)
%x0=[41.0680233604586,0.200000000000000,20.9329004294496,139.388347648318,182.153860081774,123.742573067477,697.717622740244];
%-----------------



out_ac=run_sim(x0,"kask4_ac");
freq_0=out_ac.freq_vect;
Aac_0=out_ac.variable_mat(6,:);
Aac_0=db(real(Aac_0));
%Aac_0=real(Aac_0);
%Aac_0=10*log(real(Aac_0));
fg_0=get_fg(Aac_0,freq_0);
GBW0=Aac_0(1)*fg_0;
GBW=log(Aac_0(1)*fg_0);
b=boost(Aac_0);
ku0=real(Aac_0(1));

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
lb=[0.01 0.01 0.01 0.01 0.01 0.01 0.01]; ub=[10 10 10 10 10 10 10];

%% optimize
fun=@(xs) obj_fun(xs2x(xs));
constr=@(xs) nonlcon(xs2x(xs));
opts=optimoptions('fmincon','Display','iter-detailed','PlotFcn',{'optimplotfvalconstr','optimplotx'},'FinDiffRelStep',1e-5);
xs_opt=fmincon(fun,x2xs(x0),[],[],[],[],lb,ub,constr,opts);
x_opt=xs2x(xs_opt);
%% optimal point results
close all;
out_ac=run_sim(x_opt,"kask4_ac");
freq_opt=out_ac.freq_vect;
Aac_opt=out_ac.variable_mat(6,:);
Aac_opt=db(real(Aac_opt));
fg_opt=get_fg(Aac_opt,freq_opt);
ku_opt=real(Aac_opt(1));
GBW_opt=Aac_opt(1)*fg_opt;
b_opt=boost(Aac_opt);



%% Pareto


fun=@(xs) obj_pareto(xs2x(xs));
p_constr=@(xs) pareto_constr(xs2x(xs));
opts=optimoptions('paretosearch','Display','iter','PlotFcn',{'psplotparetof'},'InitialPoints',x2xs(x0),'MaxIterations',15,'MaxTime',3600);
x_pareto=paretosearch(fun,7,[],[],[],[],lb,ub,p_constr,opts);

%% get pareto points

for i=1:length(x_pareto)
    out_ac=run_sim(xs2x(x_pareto(i,:)),"kask4_ac");
    freq=out_ac.freq_vect;
    Aac=out_ac.variable_mat(6,:);

    fg_pareto(i)=get_fg(Aac,freq);
    ku_pareto(i)=real(Aac(1));
    b_pareto=boost(Aac);
    GBW_pareto=real(Aac(1))*fg_pareto(i);
          
end
save("results/latest.mat");

x_pareto_scaled=xs2x(x_pareto);


display_results






