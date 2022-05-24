function bst = boost(freq,Aac)
%BOOST Obliczenie podbicia
%   AAc - wektor odpowiedzi AC układu.
%   Funckja obliczająca podbice.
%   Podbicie rozumiane jako różnica międzu wzmocnienim
%   małoczęstotliwościowym ku0 a wzmocnieniem maksymalnym ku_max (ku0-ku)
Aac=db(abs(Aac));
ku0=Aac(1);
[ku_max, idx_max]=max(Aac);
points_number=1;
if((idx_max+points_number < length(freq) && idx_max-points_number>= 1))
    f=freq(idx_max-points_number:idx_max+points_number);
    k=Aac(idx_max-points_number:idx_max+points_number);
    x=f;
    y=k;
    x1=linspace(f(1),f(end),100);
    [p,S,mu]=polyfit(x,y,2);
    ku_approx=polyval(p,(x1-mu(1))/mu(2));
    [ku_max, max_approx_idx]=max(ku_approx);
%     figure
%     semilogx(freq,Aac,'.','LineWidth',2,'MarkerSize',20);
%     hold on
%     semilogx(x1,ku_approx,'LineWidth',2)
%     hold on
%     plot(x1(max_approx_idx),ku_max,'x','Color','green','LineWidth',3,'MarkerSize',8);
%     xlabel("f [Hz]")
%     ylabel("k_u [dB]")
%     xlim([freq(idx_max-10) freq(idx_max+10)])
%     title("Interpolacja maksymalnego k_u")
%     legend("Spice","Aproksymacja","k_{umax}")
%     hold off


end

bst=ku_max-ku0;

end

