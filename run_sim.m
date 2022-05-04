function [results] = run_sim(params)
%RUN_SIM Summary of this function goes here
%   Detailed explanation goes here

%replace spice_string with path to SPICE:
%----------------------------------
spice_string="XVIIx64.exe";
%----------------------------------

modify_params(params);
system(spice_string+" -Run -b kask4.asc");
results=LTspice2Matlab("kask4.raw");

end

