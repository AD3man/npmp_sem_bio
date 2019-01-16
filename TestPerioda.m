rng default;
clear;
 
options = optimoptions('ga','MaxStallGenerations',5,'MaxGenerations',1, 'UseParallel', false, 'UseVectorized', false)

%@(x)params_as_func(x,r)
% x - parametri, ki jih testira ga - definiraš v params_as_func.m
% r - 0: vrni periodo ali 1: vrni negirano amplitudo
[x,fval,exitflag,output,population,scores] = ga(@(x)params_as_func(x,0),4,[],[],[],[],[1,1,5,2],[5,5,15,5],[],options);
