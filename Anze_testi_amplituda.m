rng default;
% Pozeni to datoteko.
% ko bos sel spat probaj poslat 

diary './logs/log_testiranje_najvecAmpl_.txt' % V kater file se bo output shranil
 
options = optimoptions('ga','MaxGenerations',100, 'UseParallel', true, 'UseVectorized', false);

% meje parametrov. Nastavljene tako, da je zacetek oscilacije vecinoma
% ob okoli 500000. Isce se parametre za najvisjo amplitudo.
%meje_od = [0.1,9.5,4,3]; 
%meje_do = [0.5,10,6,4];

meje_od = [0.5,0,1,3]; 
meje_do = [1,10,50,4];
set(0,'DefaultFigureVisible','off')
%opt_max_ampl_rez_10_80 = ga(@(x)params_as_func(x,2,20,0.8),4,[],[],[],[],meje_od,meje_do,[],[4],options);
%%%opt_max_ampl_rez_5_80 = ga(@(x)params_as_func(x,2,5,0.8),4,[],[],[],[],meje_od,meje_do,[],[4],options);
%opt_max_ampl_rez_20_20 = ga(@(x)params_as_func(x,2,5,0.2),4,[],[],[],[],meje_od,meje_do,[],[4],options);
%opt_max_ampl_rez_20_20 = ga(@(x)params_as_func(x,2,5,1.0),4,[],[],[],[],meje_od,meje_do,[],[4],options);
%save 'retultati_5_20_in_100';

opt_max_ampl_rez_10_100 = ga(@(x)params_as_func(x,1,10,1.0),4,[],[],[],[],meje_od,meje_do,[],[4],options);
save 'retultati_10_100';
opt_max_ampl_rez_20_20 = ga(@(x)params_as_func(x,1,20,0.2),4,[],[],[],[],meje_od,meje_do,[],[4],options);
save 'retultati_20_20';

diary off;