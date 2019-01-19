rng default;
% Pozeni to datoteko.
% ko bos sel spat probaj poslat spodaj omenjeni log file. Zapis je
% tekstovni in ponavljajoc, zato se bo lahko mocno skompresiral (rar ali zip, primer: 135MB -> 22kB).

% V kater log file se bo output shranil
diary './logs/log_testiranje_najvecje_Amplitude_omejeno.txt' 
 
options = optimoptions('ga','MaxGenerations',100, 'UseParallel', true, 'UseVectorized', false);

% meje parametrov. Nastavljene tako, da je zacetek oscilacije vecinoma
% ob okoli 500000. Isce se parametre za najvisjo amplitudo.
meje_od = [0.5,0,1,1];
meje_do = [1,10,50,4];
set(0,'DefaultFigureVisible','off')
opt_max_ampl_rez_10_80 = ga(@(x)params_as_func(x,1,10,0.8),4,[],[],[],[],meje_od,meje_do,[],[4],options);
opt_max_ampl_rez_5_80 = ga(@(x)params_as_func(x,1,5,0.8),4,[],[],[],[],meje_od,meje_do,[],[4],options);
opt_max_ampl_rez_10_20 = ga(@(x)params_as_func(x,1,10,0.2),4,[],[],[],[],meje_od,meje_do,[],[4],options);

%zapremo pisanje v log datoteko. Isto po?eni, ce zelis dostopati do
%datoteke medtem ko matlab lavfa
diary off;