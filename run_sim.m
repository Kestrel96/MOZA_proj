function [results] = run_sim(params,filename)
%RUN_SIM Uruchomienie LTSpice
%    Funkcja uruchamiająca LTspice z poziomu matlaba. 
%   params -wektor parametrów
%   filename - nazwa pliku symulacji (np. kask4_ac). Musi znadjować się w
%   pliku spice.

%Zmienić zmienną spice_string na ścieżkę do pliku wykonywalnego LTSpice.
%----------------------------------
spice_string="XVIIx64.exe";
%----------------------------------

modify_params(params);
filename="./spice/"+filename;
system(spice_string+" -Run -b "+ filename+".asc");
results=LTspice2Matlab(filename+".raw");

end

