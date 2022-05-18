%% compare results
close all;


out_ac=run_sim(x_opt,"kask4_ac");
freq=out_ac.freq_vect;
Aac=out_ac.variable_mat(6,:);
fg=get_fg(Aac,freq);
optimal_figure=figure('Name','OmptimalResults','NumberTitle','off','Position', [0 0 1600 900]);
semilogx(freq_0,real(Aac_0),'Color','blue','LineWidth',2)

xline(fg_0,"--","Color",'blue','Label','fg_{0}','LabelVerticalAlignment','bottom')
yline(real(Aac_0(1))-3,"-.",'Color','blue','Label','k_{u0(3dB)}')
hold on
semilogx(freq,real(Aac_opt),'Color','red','LineWidth',2);
xline(fg_opt,"--","Color",'red','Label','fg_{opt}','LabelVerticalAlignment','top')
yline(real(Aac_opt(1))-3,"-.",'Color','red','Label','k_{uopt(3dB)}')
xline(200e6,"Color",'green','Label',"200 MHz",'LabelVerticalAlignment','middle')

legend("Punkt startowy","f_{g0}","k_{u0(3dB)}","Punkt optymalny","f_{gopt}","k_{uopt(3dB)}","200 MHz",'Location','best')
title("Porównanie wyników w pkt. początkowym i optymalnym")
xlabel("f [Hz]")
ylabel("k_u [dB]")
comparison_path=plots_path+"/comparison.png";
saveas(optimal_figure,comparison_path);


%% display pareto


pareto_figure=figure('Name','Pareto','NumberTitle','off','Position', [0 0 1600 900]);
for i=1:length(x_pareto)
    scatter(log(fg_pareto(i)),ku_pareto(i),'LineWidth',2);    
    set ( gca, 'xdir', 'reverse' )
    set ( gca, 'ydir', 'reverse' )
    hold on  
    
end
title("Granica Pareto i punkt optymalny GBW");
plot(log(fg_opt),ku_opt,'+','MarkerSize',15,'Color','red','LineWidth',3);
text(log(fg_opt),ku_opt+0.5,"Punkt optymalny GBW",'HorizontalAlignment','center');

hold on
plot(log(fg_0),ku0,'x','MarkerSize',15,'Color','green','LineWidth',2);
text(log(fg_0),ku0+0.5,"Punkt startowy",'HorizontalAlignment','center');
xlabel("log(f) [Hz]");
ylabel("k_u [dB]");
hold off
pareto_path=plots_path+"/pareto_front.png";
saveas(pareto_figure,pareto_path)





















