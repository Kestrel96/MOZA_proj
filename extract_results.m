function [data,header] = extract_results()
%EXTRECT_RESULTS Wyłuskanie danych z przebiegu optymalizacji.
%   Funckja wyciąga dane takie jak ilość iteracji, wyowłań funckji, punkty
%   optymalizowane, spełnienie ograniczeń, warotść f. celu.

results=importdata("output_results");

data=results.data;
header=results.colheaders;
end

