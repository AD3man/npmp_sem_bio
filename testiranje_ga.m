rng default;
clear;
%Zelim testirati od -1 do 3
% se pravi med x >= -1 in x <= 3
%Po APIju to pretvorim v: -x <= 1 in x <= 2
% Koeficiente pred x dam v matriko A,
% desno stran pa v  matriko b. Odvisna sta si po srolpcih A in vrsticah b
A = [-1; 1];
b = [1, 5];

options = optimoptions('ga','MaxGenerations',5)

[x,fval,exitflag,output,population,scores] = ga(@params_as_func,1,[],[],[],[],1,5,[], 1,options);

