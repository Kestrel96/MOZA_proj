%% Pkt startowy
x0=[5 15 320 220 200 45 50];
results_path="results";
plots_path="plots";

out_ac=run_sim(x0,"kask4_ac");
freq_0=out_ac.freq_vect;
Aac_0=out_ac.variable_mat(6,:);
Aac_0=db(abs(Aac_0));
fg_0=get_fg(Aac_0,freq_0);
GBW0=Aac_0(1)*fg_0;
GBW0l=log(Aac_0(1)*fg_0);
b=boost(Aac_0);
ku0=abs(Aac_0(1));

starting_figure=figure('Name','Wyniki w pkt. pocz.','NumberTitle','off','Position', [0 0 1600 900]);
figure(starting_figure)
semilogx(freq_0,abs(Aac_0),'Color','blue','LineWidth',2)
ylim([-10 50])
xline(fg_0,"--","Color",'blue','Label',sprintf("f_{g}=%e",fg_0))
yline(abs(Aac_0(1))-3,"--")
xline(200e6,"Color",'green','Label',"200MHz")
legend("k_{u}")
title("Wyniki w punkcie początkowym")
xlabel("Częstotliwość [Hz]")
ylabel("k_{u}[dB]")