function  modify_params(params)
%MODIFY_PARAMS Summary of this function goes here
%   Detailed explanation goes here

%.PARAM REE1=5
%.PARAM REE2=8
%.PARAM CEE=50p
%.PARAM CG=50p
%.PARAM RE=200
%.PARAM RC2=81
%.PARAM RC3=330

%.PARAM Voff=0
%.PARAM Vs=0.1
%.PARAM fs=1k
names=["REE1" "REE2" "RE" "RC2" "RC3" "CEE" "CG" ];
suffix=[' ' ' '  ' ' ' ' ' ' 'p' 'p'];
file = fopen("spice/params.inc",'w');

for i=1:length(params)
    txt=sprintf(".PARAM %s=%i%c\n",names(i),params(i),suffix(i));
    fprintf(file,txt);
end
ending_params=sprintf("\n.PARAM Voff=0\n.PARAM Vs=0.1\n.PARAM fs=1k\n");
fprintf(file,ending_params);

fclose(file);

end

