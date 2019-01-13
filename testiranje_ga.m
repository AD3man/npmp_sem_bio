rng default;
clear;
%Zelim testirati od -1 do 3
% se pravi med x >= -1 in x <= 3
%Po APIju to pretvorim v: -x <= 1 in x <= 2
% Koeficiente pred x dam v matriko A,
% desno stran pa v  matriko b. Odvisna sta si po srolpcih A in vrsticah b
A = [-1; 1];
b = [1, 3];
[x,fval,exitflag,output,population,scores] = ga(@testga,1,[],[],[],[],-1,1,[], 1);

