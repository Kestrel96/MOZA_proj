function [x_pareto,fval,exitflag,optim_out] = multiobj_optimization_wrapper(x0)
%OPTIMIZATION_WRAPPER Funckja uruchamiająca i przeporwadzająca
%optymalizację wielokryterialną.
%   Funkcja wykorzystuje mechanizm funkcji zagnieżdżonych do przekazywania
%  zmiennych między funkcjami celu i ograniczeń, co pozwala na jedną
%  symulację dla obliczenia f celu i ograniczeń.
% x0 - punkt startowy symulacji (nie skalowany).

%% Zmienne dla współdzielonego wykonywania
xLast = [];
c_nested = [];
ku_nested=[];
fg_nested=[];
b_nested=[];


%% Skalowanie wektora parametrów
x2xs=@ (xs) xs./x0; %do 1
xs2x=@ (x) x.*x0; % do wartości rzeczywistych
%% Ograniczenia górne i dolne
lb=[0.01 0.1 0.1 0.1 0.1 0.1 0.1]; ub=[2 2 5 5 10 10 10];

%% Uchwyty do funkcji zagnieżdżonych
fun=@(xs) obj_fun(xs2x(xs)); %uchwyt do f. celu
constr=@(xs) nonlcon(xs2x(xs)); %uchwy to f. ograniczeń
%% Opcje optymalizacji

pareto_size=50;
opts=optimoptions('paretosearch','Display','iter', 'ParetoSetSize',pareto_size,'MaxTime',1800,'PlotFcn',{'psplotparetof'}, ...
    'InitialPoints',x2xs(x0));

[xs_pareto,fval,exitflag,optim_out] = paretosearch(fun,7,[],[],[],[],lb,ub,constr,opts);

if(pareto_size > length(xs_pareto))% W razie wczesnego zakończenia poszukiwania.
    pareto_size= length(xs_pareto);
end
for i=1:pareto_size
    x_pareto(i,:)=xs2x(xs_pareto(i,:));
end




    function [p_out] = obj_fun(x)
        %OBJ_FUN Funkcja celu.
        %   Funckja obliczająca przeskalowaną wartość BGW (log(GBW)). Każde
        %   wywołanie wymaga uruchomienia symulatora.
        %   x - przeskalowany do właściwej postaci wektore parametrów
        %   optymalizowanych
        if ~isequal(x,xLast) % Check if computation is necessary
            [fg_nested,ku_nested,b_nested]=get_working_params(x);
            xLast = x;
        end



        ku=-ku_nested;
        fg=-log10(fg_nested);
        p_out=[ku;fg];
        %wyświetlenie wartości otrzymanych z symulacji
        txt=sprintf("Boost: %0.3f; fg:%e; ku=%0.3f\n",b_nested,fg_nested,ku_nested);
        fprintf(txt);

    end


    function [c,ceq] = nonlcon(x)
        %NONLCON Nierównościowe ograniczenia dla zadania optymalizacji.
        %   Ogranicznenia nierównościowe na fg, ku i podbicie.
        %   x - przeskalowany do właściwej postaci wektore parametrów
        %   optymalizowanych
        display=0;
        if ~isequal(x,xLast)

            [fg_nested,ku_nested,b_nested]=get_working_params(x);
            xLast = x;
            display=1;
        end
        %minimalne i mksymalne dopuszczalne parametry
        fgmin=200e6;
        kumin=20;
        bmax=1;

        %wektor ograniczeń (c=<0)
        c_nested(1)=-(fg_nested/fgmin-1);
        c_nested(2)=-(ku_nested/kumin-1);
        c_nested(3)=(b_nested-bmax);
        c=c_nested;
        ceq=[];
        if (display)
            fprintf("Calculating constraints!\n kuc=%0.3f; fgc=%e; bc=%0.3f\n",c_nested(1),c_nested(2),c_nested(3));
            display=0;
        end
    end





end

