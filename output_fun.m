function stop = output_fun(x,optimValues,state)
%OUTPUT_FUN Funckja wyjściowa
%   Funkcja uruchamiana dla każdej iteracji. Zapisuje przebieg wartości f.
%   celu, spełnienie ograniczeń ilość iteracji i wywoałań f. celu, punkty
%   dla każdej iteracji. Standardowa postać matlaba.

fileID = fopen('output_results','a+');

if(optimValues.constrviolation >10e-6) % warunek spełnienia ograniczeń (tolerancja domyślna dla matlaba)
    feasible=0;
else
    feasible=1;
end

iter=optimValues.iteration;
fcnt=optimValues.funccount;
fval=optimValues.fval;
output_fun_results=[iter x feasible fcnt fval];

fprintf(fileID,"%f %f %f %f %f %f %f %f %f %f %f\n",output_fun_results);
fclose(fileID);

stop=0;
end

