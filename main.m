%p0=[5 8 50 50 150 81 330];
p0=[3.3 0.1 300 500 130 76 370];
%1 można delikatnie sterować(minimum 3.9) 
%2 mały wpływ, można nie ruszać (chociaż jednak można próbować
%minimalizować)
%3 podbicie i wzmocnienie
%4 nic nie zmienia
%5 lepiej nie ruszać (poprawia dół)
%6 dużo zmienia, ale nasyca tranzystory 
%ogólnie trzeba wymyślec jakąś miarę "kształtu" naszego przebiegu. Jak
%ruszmy parametr 6 to można mocniej zmienić 1 i wtedy duże GBW. Trzeba
%zpaytać profesora

out_dc=run_sim(p0,"kask4_dc");



source=out_dc.source_vect;
Vout=out_dc.variable_mat(6,:);
out_ac=run_sim(p0,"kask4_ac");
freq=out_ac.freq_vect;
Aac=out_ac.variable_mat(6,:);

%%
figure(1)
tiledlayout(3,1);
nexttile
plot(source, Vout);
nexttile
grd=gradient(Vout(10:end));
grd=grd/max(grd);
plot(grd);
ylim([0 1])
mean(grd)


%tmp=Vout./Vin;
%plot(time(100:250), tmp(100:250));

nexttile
semilogx(freq,Aac);
ylim([-20 70]);



