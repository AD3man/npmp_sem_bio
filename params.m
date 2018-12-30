% repressilator parameters
%alpha = 216;
%alpha0 = 0.001 * alpha;
%n = 2;
%beta = 5; 

alpha = 5; % min**(-1)              maksimalna hitrost transkripcije
alpha0 = 0.001 * alpha; % min**(-1) hitrost pu��anja represiranega promotorja
beta = 1; % min**(-1)        hitrost transkripcije
Kd = 10; % nM                disociacijska konstanta
delta_p = 0.1;   % min**(-1) hitrost razgradnje proteina
delta_m = 0.1;   % min**(-1) hitrost razgradnje mRNA
n = 2;                      % hillov koeficient

kappa = 0.2;  % hitrost transkripcije proteina C s strani  dodatnega gena ki ga aktivira sinhr. molekula S
kS0 = 1; % hitrost razgradnje molekule S znotraj celice
kS1 = 0.01; % hitrost tvorbe molekule S, ki jo inducira protein A
kSe = 0.01; % hitrost razgradnje molekule S izven celice
eta = 2;  % ta �und n, hitrost prehajanja sinhr. celice skozi celi�no membrano

% diffusion rate molekule S skozi prostor
D1=0.5;

% environment
size = 10; % size of the space equals [size x size]
density = 0.8; % gostota celic


% simulation parameters 
t_end = 10000;
dt = 0.1;
h=0.5; % Grid size: in micro meters - E coli size 1 um x 2 um (volume = 1 um^3)
h2=h^2;

save('params')

% Anže:
% Za prihodnost: Potrebno bo pridobiti podatke za različne vrednosti parametrov,
% zato bo potrebna neka zanjka, ki gre skozi vse vrednosti parametrov
% Moškon je sicer svetoval, da naredimo nekakšno hevristiko (genetski algoritem ali kaj drugega (jes osebno ne znam))

% podatki ki jih potrebujemo:
%   - povprečna amplituda celic ko oscilirajo glede na parametre - graf
%   - povprečna perioda celic ko oscilirajo glede na parametre - graf
%   - povprečna usklajenost celic ko oscilirajo glede na parametre - graf

clear;
%Test za getOscilationArea, ki izracuna od katerega indeksa naprej
%posamezna celica oscilira
[A_full, TT]= repressilator_S_PDE_as_func(1,1);
% A_full - rezultati simulacije
% TT - časovni koraki
stcelic = size(A_full,2)
zacetkiOSCvec = zeros(stcelic,1); % razultati za za�etke osciliranja
povpAplitudOSCvec = zeros(stcelic,1); % razultati za povpre�je amplitud obmo�ij osciliranja
povpPeriodOSCvec = zeros(stcelic,1); % razultati za povpre�je period obmo�ij osciliranja

for i=1:stcelic
  [start_oscilacije,  povprecje_amplitud_oos, povprecje_period_oos ]= getOscilationArea(A_full(:,i), 0.2,i==10);  %debug po�ene samo pri 10. indexu
  zacetkiOSCvec(i)=start_oscilacije;
  povpAplitudOSCvec(i)=povprecje_amplitud_oos;
  povpPeriodOSCvec(i)=povprecje_period_oos;
end
rezultat =  [ zacetkiOSCvec povpAplitudOSCvec povpPeriodOSCvec ]

% pridobimo �e popre�ja za vse celice:
rezultat_povpreceno_cez_vse_celice =  [ mean(zacetkiOSCvec) mean(povpAplitudOSCvec) mean(povpPeriodOSCvec) ]
disp(sprintf('%f, ',rezultat_povpreceno_cez_vse_celice))

rezultati_hash = containers.Map();  

if(isfile('rezultati_map.mat'))
    rezultati_hash_tmp=load('rezultati_map.mat');
    rezultati_hash=rezultati_hash_tmp.rezultati_hash;
end 
tmp_params =  load('params.mat');

key = sprintf('%.2f-%.2f-%.2f',tmp_params.size, tmp_params.density, tmp_params.D1)

disp(key)
rezultati_hash(key)= rezultat_povpreceno_cez_vse_celice;
save('rezultati_map.mat','rezultati_hash');
clear rezultati_hash;
clear tmp_params;
% todo