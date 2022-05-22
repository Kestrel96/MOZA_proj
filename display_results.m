%% compare results
close all;


out_ac=run_sim(x_opt,"kask4_ac");
freq=out_ac.freq_vect;
Aac=out_ac.variable_mat(6,:);
fg=get_fg(Aac,freq);
optimal_figure=figure('Name','OmptimalResults','NumberTitle','off','Position', [0 0 1600 900]);
semilogx(freq_0,abs(Aac_0),'Color','blue','LineWidth',2)
text(10e5,ku0,sprintf("ku_{0}=%0.2f",ku0),'Color','blue','VerticalAlignment', 'bottom');

xline(fg_0,"--","Color",'blue','Label',sprintf('fg_{0}=%e',fg_0),'LabelVerticalAlignment','bottom')
yline(abs(Aac_0(1))-3,"-.",'Color','blue','Label','k_{u0(-3dB)}')
hold on
semilogx(freq,abs(Aac_opt),'Color','red','LineWidth',2);
text(10e5,ku_opt,sprintf("ku_{opt}=%0.2f",ku_opt),'Color','red','VerticalAlignment', 'bottom');
xline(fg_opt,"--","Color",'red','Label',sprintf("fg_{opt}=%e",fg_opt),'LabelVerticalAlignment','top')
yline(abs(Aac_opt(1))-3,"-.",'Color','red','Label','k_{uopt(-3dB)}')
xline(200e6,"Color",'green','Label',"200 MHz",'LabelVerticalAlignment','middle')
legend("Punkt startowy","f_{g0}","k_{u0(3dB)}","Punkt optymalny","f_{gopt}","k_{uopt(3dB)}","200 MHz",'Location','best')
title("Porównanie wyników w pkt. początkowym i optymalnym")
xlabel("f [Hz]")
ylabel("k_u [dB]")

text(1e4,5,sprintf("^{GBW_{opt}}/_{GBW_0}=%0.3f",GBW_opt/GBW0));
comparison_path=plots_path+"/comparison.png";
saveas(optimal_figure,comparison_path);

%% display optimization results
optim_out.message
fval_figure=figure('Name','Przebieg optymalziacji','NumberTitle','off','Position', [0 0 1600 900]);
semilogy(output_fcn_results(:,11),'o','MarkerSize',3,'Color','red','LineWidth',2);
title("Wartości funkcji celu w trakice optymalizacji")
xlabel("Wartość f(x)");
ylabel("Iteracja")
fval_path=plots_path+"/fval.png";
saveas(fval_figure,fval_path);



%% display pareto

if(exist('x_pareto'))
    pareto_figure=figure('Name','Pareto','NumberTitle','off','Position', [0 0 1600 900]);
    for i=1:length(x_pareto)
        scatter(log(fg_pareto(i)),ku_pareto(i),'LineWidth',2);
        text(log(fg_pareto(i)),ku_pareto(i),string(i),'HorizontalAlignment','center','VerticalAlignment', 'bottom');
        
        hold on
        
    end
    title("Granica Pareto i punkt optymalny GBW");
    plot(log(fg_opt),ku_opt,'+','MarkerSize',15,'Color','red','LineWidth',3);
    text(log(fg_opt),ku_opt,"Punkt optymalny GBW",'HorizontalAlignment','center','VerticalAlignment', 'bottom');
    set ( gca, 'xdir', 'reverse' )
    set ( gca, 'ydir', 'reverse' )
    hold on
    plot(log(fg_0),ku0,'x','MarkerSize',15,'Color','green','LineWidth',2);
    text(log(fg_0),ku0,"Punkt startowy",'HorizontalAlignment','center','VerticalAlignment', 'bottom');
    xlabel("log(f) [Hz]");
    ylabel("k_u [dB]");
    hold off
    pareto_path=plots_path+"/pareto_front.png";
    saveas(pareto_figure,pareto_path)
end




















