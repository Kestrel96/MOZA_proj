function bst = boost(Aac)
%BOOST Summary of this function goes here
%   Detailed explanation goes here
 ku0=abs(Aac(1));
 ku_max=max(real(Aac));
 bst=ku_max-ku0;

end

