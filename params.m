% repressilator parameters
%alpha = 216;
%alpha0 = 0.001 * alpha;
%n = 2;
%beta = 5; 

alpha = 5; % min**(-1)              maksimalna hitrost transkripcije
alpha0 = 0.001 * alpha; % min**(-1) hitrost pušèanja represiranega promotorja
beta = 1; % min**(-1)        hitrost transkripcije
Kd = 10; % nM                disociacijska konstanta
delta_p = 0.1;   % min**(-1) hitrost razgradnje proteina
delta_m = 0.1;   % min**(-1) hitrost razgradnje mRNA
n = 2;                      % hillov koeficient

kappa = 0.2;  % hitrost transkripcije proteina C s strani  dodatnega gena ki ga aktivira sinhr. molekula S
kS0 = 1; % hitrost razgradnje molekule S znotraj celice
kS1 = 0.01; % hitrost tvorbe molekule S, ki jo inducira protein A
kSe = 0.01; % hitrost razgradnje molekule S izven celice
eta = 2;  % ta èund n, hitrost prehajanja sinhr. celice skozi celièno membrano

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

%repressilator_PDE