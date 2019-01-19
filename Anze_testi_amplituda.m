rng default;
clear;
 
options = optimoptions('ga','MaxGenerations',100, 'UseParallel', true, 'UseVectorized', false)

%@(x)params_as_func(x,r)
% x - parametri, ki jih testira ga - definiraš v params_as_func.m
% r - 0: vrni periodo ali 1: vrni negirano amplitudo

meje_od = [0.001,0.001,0.01,1];
meje_do = [10,10,100,4];
set(0,'DefaultFigureVisible','off')
%opt_max_ampl_rez_10_80 = ga(@(x)params_as_func(x,1,10,0.8),4,[],[],[],[],meje_od,meje_do,[],options);
opt_max_ampl_rez_5_80 = ga(@(x)params_as_func(x,1,5,0.8),4,[],[],[],[],meje_od,meje_do,[],[4],options);
%opt_max_ampl_rez_10_20 = ga(@(x)params_as_func(x,1,10,0.2),4,[],[],[],[],meje_od,meje_do,[],options);