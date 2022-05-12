function fg = get_fg(Aac,freq)
%GET_FG Summary of this function goes here
%   Detailed explanation goes here
  ku0=Aac(1);
  if(ku0<10)
      fg=1;
      return
  end
  ku=ku0-3;
  idx=find(Aac < ku,1);
  fg=freq(idx);

end

