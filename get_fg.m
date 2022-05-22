function fg = get_fg(Aac,freq)
%GET_FG Obliczenie częstotliwości granicznej
%   Funckja obliczająca wartość fg. W przypadku gdy optymalizator dobierze
%   parametry tak, zę charakterystyk anie ma fizycznego sensu, fg=0.

%zabezpieczenie przed nieprawidłową charakterystyką
ku0=abs(Aac(1));
if(ku0<1)
    fg=1;
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
            ws = warning('off','all');
            [p]=polyfit(x,y,2);
            warning(ws);
            ku_approx=polyval(p,x1);
            fg_index=find(ku_approx < ku,1); %znajdź fg z interpolowanego wielomianu
            fg=x1(fg_index);
            %         figure
            %         semilogx(freq,Aac);
            %          hold on
            %          semilogx(x1,ku_approx)
            %          hold off
            %         xline(fg,'--');
            if (isempty(fg)) %jeśli nie znaleziono zwróć 0
                fg=0;
            end
        end
        
        return
        
   
end


if (isempty(fg))
    fg=0;
end

end

