function bst = boost(freq,Aac)
%BOOST Obliczenie podbicia
%   AAc - wektor odpowiedzi AC układu.
%   Funckja obliczająca podbice.
%   Podbicie rozumiane jako różnica międzu wzmocnienim
%   małoczęstotliwościowym ku0 a wzmocnieniem maksymalnym ku_max (ku0-ku)

  ku0=abs(Aac(1));
  ku_max=max(abs(Aac));
  bst=ku_max-ku0;


end

