%PAR1 Vektor samplov za eno celico 1D vektor
%PAR2 Odstopanje pri iskanju peak-ov

% vrne:
% start_oscilacije - Indeks vzorca od katerega naprej celica oscilira
% 

function [start_oscilacije] = getOscilationArea(DATA_RAW, epsilon, debug_bool)
    zanimivoPodrocje=length(DATA_RAW)/2:length(DATA_RAW);
    DATA=DATA_RAW(zanimivoPodrocje);
    %Odstrani prvo polovico rezultastov in najdi peake
    %[peaks_val, peaks_idx]= findpeaks( DATA(1:sizeD(1)/2) );
    %Najdi peake
    [peaks_val, peaks_idx]= findpeaks( DATA );
    
    % Najdi doline (lokalne minimume)
    [doline_val, doline_idx]= najdidoline(DATA,0);
    
     minlen = min(length(peaks_idx), length(doline_idx));
   
     peaks_val=peaks_val(1:minlen);
     doline_val=doline_val(1:minlen);   
     doline_idx = doline_idx(1:minlen);
     peaks_idx=peaks_idx(1:minlen);
    %Odstrani zadnji peak
    peaks_idx(end)= [];
    peaks_val(end)= [];
    
    %Odstrani prvi peak
    peaks_idx(1)= [];
    peaks_val(1)= [];
    
    %Odstrani zadnjo dolino
    doline_idx(end)= [];
    doline_val(end)= [];
    
     %Odstrani prvo dolino
    doline_idx(1)= [];
    doline_val(1)= [];
    
    %Najdi zadnjih n peakov ki se ne razlikujejo veï¿½ kot za epsilon
    %current= length(peaks_val);
    %while 1 <= current
    %    if abs( peaks_val(end) - peaks_val(current) ) > epsilon
    %        break;
    %    end
    %    current= current-1;
    %end
        
    
    % za i, sta peaks_val(i) in doline_val(i) en par pv(i)
   
    amplitude_abs = abs(peaks_val - doline_val);
    amplitude_abs_shifted=amplitude_abs(2:end);
    % izraèunamo abs(A_i - A_(i+1)) Pri tem izgubimo zadnji index - se ne
    % preverja
    razlRes = abs(amplitude_abs(1:length(amplitude_abs_shifted)) - amplitude_abs_shifted);
    razlResBool = razlRes>epsilon; % bool array, kjer se vrednost postavi na 1 kadar je  x > epsilon. Dobimo zadnji index para, ki še ne stabilno oscilira 
    predOscilacijoArr = find(razlResBool,1,'last'); % išèem zadnji element bool arraya, ki je še 1
    predOscilacijo = 0; % èe sluèajno oscilira že v prvi polovici osciliranja
    if(debug_bool == 1)
        [razlRes razlResBool] 
    end
    if(length(predOscilacijoArr) > 0) 
        predOscilacijo = predOscilacijoArr(1);
    end
    %Najdi zadnjih n peakov ki se ne razlikujejo veï¿½ kot za epsilon
    %current2= length(razlRes);
    %while 1 <= current2
    %    if razlRes > epsilon
    %        break;
    %    end
    %    current2= current2-1;
    %end
    
    if(debug_bool == 1)
        % Izris oscilacije za prikaz izraèuna
        TT=zanimivoPodrocje;
        figure()
        plot(1:length(DATA_RAW)/2,DATA_RAW(1:length(DATA_RAW)/2),'m','DisplayName','Zavržena polovica'); 
        hold on;
        plot(TT,DATA,'b','DisplayName','Evaluirana polovica'); 
       
        plot(TT(doline_idx),doline_val,'r*','DisplayName','Lokalni minimumi'); 
        plot(TT(peaks_idx),peaks_val,'g*','DisplayName','Lokalni maksimumi'); 
        plot(TT(peaks_idx(predOscilacijo+1)), DATA(peaks_idx(predOscilacijo+1)), 'y*','DisplayName','Zaèetek oscilacije'); 
        legend;
        hold off;
        %plot(length(DATA)/2:length(DATA),DATA(length(DATA)/2:length(DATA)),'b',TT(doline_idx),doline_val,'r*', TT(peaks_idx),peaks_val,'g*', TT(peaks_idx(current)), DATA(peaks_idx(current)), 'y*'); 
    end
    
    %Vrni index zacetka oscilacije. Ker dobimo index zadnjega ki je vrèji od
    %epsilon, indexu dodamo 1
    start_oscilacije= peaks_idx(predOscilacijo+1) + length(DATA_RAW)/2;  % Dodamo še polovico dolžine.
    
    %doline = {dol}
    
end

