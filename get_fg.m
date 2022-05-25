function fg = get_fg(Aac,freq)
%GET_FG Obliczenie częstotliwości granicznej
%   Funckja obliczająca wartość fg. W przypadku gdy optymalizator dobierze
%   parametry tak, zę charakterystyk nie ma fizycznego sensu zwracana jest wartość NaN.
%   Aac - wektor odpowiedzi AC układu, freq - wektor częstotliwości

%zabezpieczenie przed nieprawidłową charakterystyką
ku0=abs(Aac(1));
if(ku0<3)
    fg=NaN;
    return
end
ku=ku0-3; %wzmocnienie na poziomie -3dB

idx=find(Aac < ku,1); %indeks, dla którego wzocmienie jest najbliższe -3dB
fg=freq(idx);% wektor freq i AAc mają tę samą długość - można to wykrozytstać do znalezienie fg


if(isempty(idx)== 0)% jeżeli nie znaleziono indeksu pomiń interpolację
    %interpolacja wielomianem 2go stopnia
    if(idx==length(freq)) %warunki na indkes i długość wektora, potrzebne są 3 punkty.
        fg=freq(idx);
    end
    if((idx+1 < length(freq) && idx-1 >= 1)) %jeżeli punkty sa dostępne wykonaj interpolację
        f=freq(idx-1:idx+1);
        k=Aac(idx-1:idx+1);
        x=f;
        y=k;
        x1=linspace(f(1),f(3),100);
        [p,S,mu]=polyfit(x,y,2);
        ku_approx=polyval(p,(x1-mu(1))/mu(2));
        fg_index=find(ku_approx < ku,1); %znajdź fg z interpolowanego wielomianu
        fg=x1(fg_index);
%         figure
%         semilogx(freq,Aac,'.','LineWidth',2,'MarkerSize',20);
%         hold on
%         semilogx(x1,ku_approx,'LineWidth',2)
%         xlabel("f [Hz]")
%         ylabel("k_u [dB]")
%         xlim([freq(idx-10) freq(idx+10)])
%         xline(fg,'--');
%         title("Interpolacja cz. granicznej")
% 
%         legend("Spice","Aproksymacja","f_g")
%         hold off

        if (isempty(fg)) %jeśli nie znaleziono zwróć 0
            fg=0;
        end
    end

    return


end


if (isempty(fg))
    fg=NaN;
end

end

