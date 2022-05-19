function [data,header] = extract_results()
%EXTRECT_RESULTS Summary of this function goes here
%   Detailed explanation goes here

results=importdata("output_results");

data=results.data;
header=results.colheaders;
end

