rng default;
clear;
 
                                                                        % Aktiviram paralelizacijo.
options = optimoptions('ga','MaxStallGenerations',5,'MaxGenerations',5, 'UseParallel', true, 'UseVectorized', false)
% testiram za 2 vhodna parametra z vrednostima od 1 do 5.

%@(x)params_as_func(x,r) je anonimna funkcija, zato ker ima params_as_func
% 2 vhoda
% x - parametri, ki jih testira ga - definiraš v params_as_func.m
% r - 0: vrni periodo ali 1: vrni negirano amplitudo
[x,fval,exitflag,output,population,scores] = ga(@(x)params_as_func(x,0),2,[],[],[],[],[1;1],[5,5],[],options);

