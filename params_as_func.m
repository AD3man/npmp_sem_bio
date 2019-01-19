function y = params_as_func(par, perorampl, size_p, density)
    % y - povpreËna perioda ali negirana povpreËna amplituda


    % repressilator parameters
    %alpha = 216;
    %alpha0 = 0.001 * alpha;
    %n = 2;
    %beta = 5; 
    fprintf('Testiram: alpha: %f   beta: %f   kd: %f   n: %f - ', par(1),par(2), par(3), par(4));
    tic;
    p={};
    p.alpha = par(1); % min**(-1)              maksimalna hitrost transkripcije
    p.alpha0 = 0.001 * p.alpha; % min**(-1) hitrost puÔøΩÔøΩanja represiranega promotorja
    p.beta = par(2); %1; % min**(-1)        hitrost transkripcije
    p.Kd = par(3); % nM                disociacijska konstanta
    p.delta_p = 0.1;   % min**(-1) hitrost razgradnje proteina
    p.delta_m = 0.1;   % min**(-1) hitrost razgradnje mRNA
    p.n = par(4);                      % hillov koeficient

    p.kappa = 0.2;  % hitrost transkripcije proteina C s strani  dodatnega gena ki ga aktivira sinhr. molekula S
    p.kS0 = 1; % hitrost razgradnje molekule S znotraj celice
    p.kS1 = 0.01; % hitrost tvorbe molekule S, ki jo inducira protein A
    p.kSe = 0.01; % hitrost razgradnje molekule S izven celice
    p.eta = 2;  % ta ÔøΩund n, hitrost prehajanja sinhr. celice skozi celiÔøΩno membrano

    % diffusion rate molekule S skozi prostor
    p.D1=0.5;

    % environment
    p.size_polje = size_p; % size of the space equals [size x size]
    p.density = density; % gostota celic


    % simulation parameters 
    p.t_end = 10000;
    p.dt = 0.1;
    p.h=0.5; % Grid size: in micro meters - E coli size 1 um x 2 um (volume = 1 um^3)
    p.h2=p.h^2;

    save('params')

    % An≈æe:
    % Za prihodnost: Potrebno bo pridobiti podatke za razliƒçne vrednosti parametrov,
    % zato bo potrebna neka zanjka, ki gre skozi vse vrednosti parametrov
    % Mo≈°kon je sicer svetoval, da naredimo nekak≈°no hevristiko (genetski algoritem ali kaj drugega (jes osebno ne znam))

    % podatki ki jih potrebujemo:
    %   - povpreƒçna amplituda celic ko oscilirajo glede na parametre - graf
    %   - povpreƒçna perioda celic ko oscilirajo glede na parametre - graf
    %   - povpreƒçna usklajenost celic ko oscilirajo glede na parametre - graf

    %{
    current_afull_key=sprintf('%d',size_polje);

    a_fulls_map = containers.Map(); 
    a_fulls_map_filename='a_fulls/a_fulls_map.mat';
    if(isfile(a_fulls_map_filename))
        a_fulls_map_tmp=load(a_fulls_map_filename);
        a_fulls_map=a_fulls_map_tmp.a_fulls_map;
        clear a_fulls_map_tmp;
    end

    %Test za getOscilationArea, ki izracuna od katerega indeksa naprej
    %posamezna celica oscilira
    A_full=[];
    TT = [];
    if  a_fulls_map.isKey(current_afull_key)
      ret= a_fulls_map(current_afull_key);
      A_full=ret(:,1:end-1);
      TT=ret(:,end-1:end);
      clear ret;
      fprintf('Pridobil [A_full, TT] iz hashmapa\n');
    else
         fprintf('Ni [A_full, TT] v hashmapu, generiram novega\n');
        [A_full, TT]= repressilator_S_PDE_as_func(1,1);
        a_fulls_map(current_afull_key)= [A_full, TT];
         fprintf('Shranil novi [A_full, TT] v hashmap!\n');
         save(a_fulls_map_filename,'a_fulls_map', '-v7.3' );
    end
    %}
    [A_full, TT]= repressilator_S_PDE_as_func(1,1,p);

    % A_full - rezultati simulacije
    % TT - ƒçasovni koraki
    stcelic = size(A_full,2);
    zacetkiOSCvec = zeros(stcelic,1); % razultati za zaËetke osciliranja
    povpAplitudOSCvec = zeros(stcelic,1); % razultati za povpreËje amplitud obmoËij osciliranja
    povpPeriodOSCvec = zeros(stcelic,1); % razultati za povpreËje period obmoËij osciliranja

    for i=1:stcelic
      [start_oscilacije,  povprecje_amplitud_oos, povprecje_period_oos ]= getOscilationArea(A_full(:,i), 0.2,0);  %debug poûene samo pri 10. indexu
      zacetkiOSCvec(i)=start_oscilacije;
      povpAplitudOSCvec(i)=povprecje_amplitud_oos;
      povpPeriodOSCvec(i)=povprecje_period_oos;
    end
    clear i;
    
    rezultat =  [ zacetkiOSCvec povpAplitudOSCvec povpPeriodOSCvec ];

    % pridobimo öe popreËja za vse celice:
    rezultat_povpreceno_cez_vse_celice =  [ mean(zacetkiOSCvec) mean(povpAplitudOSCvec) mean(povpPeriodOSCvec) ];
   
    fprintf('rezultai so: zacOsc=%f, povpAmpl=%f, povprPer=%f |===================\n', rezultat_povpreceno_cez_vse_celice(1),rezultat_povpreceno_cez_vse_celice(2), rezultat_povpreceno_cez_vse_celice(3));
    if(perorampl == 0)
        %vrnem periodo
        y = rezultat_povpreceno_cez_vse_celice(3);
    else
        % vrnem negirano amplitudo
        y = -rezultat_povpreceno_cez_vse_celice(2);
    end
    
    
    %disp(sprintf('%f, ',rezultat_povpreceno_cez_vse_celice))
    %{
    rezultati_hash = containers.Map();  

    if(isfile('rezultati_map.mat'))
        rezultati_hash_tmp=load('rezultati_map.mat');
        rezultati_hash=rezultati_hash_tmp.rezultati_hash;
        clear rezultati_hash_tmp;
    end 

    key = sprintf('%.2f-%.2f-%.2f',p.size_polje, p.density, p.D1)

    disp(key)
    rezultati_hash(key)= rezultat_povpreceno_cez_vse_celice;
    save('rezultati_map.mat','rezultati_hash');
    clear rezultati_hash;
    clear tmp_params;
    %}
    toc

end
% todo
% z ga (genetic algorithm) oz podobnim za vse parametre poiskati najveËjo
% amplitudo (npr 100 molov) z najmanjöo periodo
% Ëe imamo cajt öe z lokalnimi minimumi poiöËemo najbolj oddaljene
% parametre, katerih rezultat öe oscilira

% usklajenosti ni potrebno primerjati