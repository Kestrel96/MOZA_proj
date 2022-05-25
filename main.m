clear
close all;
%% Wybór punktu startowego (ku0 oraz fg0 odnoszą się do pkt startowego w całym skrypcie)
x0=[5 15 320 220 200 45 50];
results_path="results";
plots_path="plots";
%% Punkt startowy
out_ac=run_sim(x0,"kask4_ac");
freq_0=out_ac.freq_vect;
Aac_0=out_ac.variable_mat(6,:);
Aac_0=db(abs(Aac_0));
fg_0=get_fg(Aac_0,freq_0);
GBW0=Aac_0(1)*fg_0;
GBW0l=log(Aac_0(1)*fg_0);
b=boost(freq_0,Aac_0);
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

starting_figure_path=plots_path+"/starting_point.png";
saveas(starting_figure,starting_figure_path);



%% Przygotowanie pliku do zbierania danych z optymalizatora
delete output_results
fileID = fopen('output_results','a+');
header=["iter" "x1" "x2" "x3" "x4" "x5" "x6" "x7" "feasible" "fcnt" "fval"];
fprintf(fileID,"%s %s %s %s %s %s %s %s %s %s %s\n",header);
fclose(fileID);

%% Optymalizacja
tic;
[x_opt,fval_opt,exitflag,optim_out]=optimization_wrapper(x0);
elapsed=toc;

%% Wyniki w pkt. optymalnym
out_ac=run_sim(x_opt,"kask4_ac");
freq_opt=out_ac.freq_vect;
Aac_opt=out_ac.variable_mat(6,:);
Aac_opt=db(abs(Aac_opt));
fg_opt=get_fg(Aac_opt,freq_opt);
ku_opt=abs(Aac_opt(1));
GBW_opt=Aac_opt(1)*fg_opt;
b_opt=boost(freq_opt,Aac_opt);
disp(ku_opt);
disp(fg_opt);
[output_fcn_results,header]=extract_results();


%% Optymalizacja wielokryterialna
tic
[x_pareto,fval_multi,exitflag_multi,optim_out_multi] = multiobj_optimization_wrapper(x0);
elapsed_multi=toc;
%% Wyniki dla zbioru Pareto

for i=1:length(x_pareto)
    out_ac=run_sim(x_pareto(i,:),"kask4_ac");
    freq_0=out_ac.freq_vect;
    Aac=out_ac.variable_mat(6,:);
    Aac=db(abs(Aac));
    fg_pareto=get_fg(Aac,freq);
    ku_pareto=Aac(1);

end


%% Zapisanie danych
save_path=results_path+"/latest.mat";
save(save_path);
display_results






