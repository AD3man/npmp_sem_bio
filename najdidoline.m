function [doline_vrednosti, doline_idx] = najdiDoline(DATA, debug_bool)
    % Najde doline (localne minimume) celotnega row vektorja DATA.
    % Vrne vrednosti minimuma in njegovo pozicijo -> za i: minimum na poziciji doline_idx(i) ima vrednost doline_vrednosti(i)

    min_bool = islocalmin(DATA);
    doline_idx= find(min_bool);  % že urejeno po vrsti
    doline_vrednosti = DATA(doline_idx);
    
    if(debug_bool == 1)
        TT=1:length(DATA)
        figure()
        plot(TT,DATA,'b',TT(doline_idx),doline_vrednosti,'r*'); 
    end
end