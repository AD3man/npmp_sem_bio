rng default;
% Pozeni to datoteko.
% ko bos sel spat probaj poslat 

diary './logs/log_testiranje_najvecje_Amplitude_oomejeno.txt' % V kater file se bo output shranil
 
options = optimoptions('ga','MaxGenerations',100, 'UseParallel', true, 'UseVectorized', false)

% meje parametrov. Nastavljene tako, da je zacetek oscilacije vecinoma
% ob okoli 500000. Isce se parametre za najvisjo amplitudo.
meje_od = [0.5,0,1,1]; 
meje_do = [1,10,50,4];
set(0,'DefaultFigureVisible','off')
opt_max_ampl_rez_10_80 = ga(@(x)params_as_func(x,1,10,0.8),4,[],[],[],[],meje_od,meje_do,[],[4],options);
%opt_max_ampl_rez_5_80 = ga(@(x)params_as_func(x,1,5,0.8),4,[],[],[],[],meje_od,meje_do,[],[4],options);
opt_max_ampl_rez_10_20 = ga(@(x)params_as_func(x,1,10,0.2),4,[],[],[],[],meje_od,meje_do,[],[4],options);