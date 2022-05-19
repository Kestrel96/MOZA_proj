function fg = get_fg(Aac,freq)
%GET_FG Summary of this function goes here
%   Detailed explanation goes here
ku0=real(Aac(1));
if(ku0<1)
    fg=1;
    return
end
ku=ku0-3;



idx=find(Aac < ku,1);
fg=freq(idx);

if(isempty(idx)== 0)
    if((idx+1 > length(freq) || idx-1 < length(freq)))
        %f=[freq(idx-1) freq(idx) freq(idx+1)];
        f=freq(idx-1:idx+1);
        %k=[Aac(idx-1) Aac(idx) Aac(idx+1)];
        k=Aac(idx-1:idx+1);
        x=f;
        y=k;
        x1=linspace(f(1),f(3),5);
        [p, ~,~]=polyfit(x,y,2);
        ku_approx=polyval(p,x1);
        fg_index=find(ku_approx < ku,1);
        fg=x1(fg_index);
        %     semilogx(freq,Aac);
        %     hold on
        %     semilogx(x1,ku_approx)
        %     xline(fg,'--');
        if (isempty(fg))
            fg=0;
        end
        
        return
        
    end
end


if (isempty(fg))
    fg=0;
end

end

