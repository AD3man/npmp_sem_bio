%PAR1 Vektor samplov za eno celico 1D vektor
%PAR2 Odstopanje pri iskanju peak-ov
%REZ  Indeks vzorca od katerega naprej celica oscilira

function [OUT] = getOscilationArea(DATA, epsilon)

%Odstrani prvo polovico rezultastov in najdi peake
%[peaks_val, peaks_idx]= findpeaks( DATA(1:size(DATA)/2) );
%Najdi peake
[peaks_val, peaks_idx]= findpeaks( DATA );

%Odstrani zadnji peak
peaks_idx(end)= [];
peaks_val(end)= [];

%Najdi zadnjih n peakov ki se ne razlikujejo ve� kot za epsilon
current= length(peaks_val);
while 1 <= current
    if abs( peaks_val(end) - peaks_val(current) ) > epsilon
        break;
    end
    current= current-1;
end

%Vrni index zacetka oscilacije
OUT= peaks_idx(current);
end

