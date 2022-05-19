function stop = output_fun(x,optimValues,state)
%OUTPUT_FUN Summary of this function goes here
%   Detailed explanation goes here

fileID = fopen('output_results','a+');

if(optimValues.constrviolation >10e-6)
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

