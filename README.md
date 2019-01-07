# npmp sem bio: Analiza oscilacij PDE

### Naloga do 14.1.2018:

1. Z ga (genetic algorithm: https://www.mathworks.com/help/gads/ga.html) oz podobnim za vse parametre poiskati največjo amplitudo (npr 100 molov) z najmanjšo periodo.
    1. Če imamo cajt še z lokalnimi minimumi (https://www.mathworks.com/help/matlab/ref/fminsearch.html) poiščemo najbolj oddaljene parametre od najboljših, katerih rezultat še oscilira.
    1. Usklajenosti ni potrebno primerjati.
1.  Izris grafov glede na rezultate ??

#### Do sedaj imamo:

- Pozicija celic se lahko shrani in potem naloži, da ni potrebno povprečiti 30 poskusov.
- Iskanje območja osciliranja za vsako celico posebej.
- Izračun popvrečnih amplitud in period za vse celice

# Od tu nnaprej je za arhiv:

> Osredotočenje do 7.1.2018:

> 1. Najdi oscilacije ( zavrži prvo polovico rezultatov, in zadnji peak(ker ni peak) in išči vrhove in doline (findpeaks) )
    
>    1. če amplituda zadnjih k vrhov enaka, potem oscilira

> 1. Poišči sinhronizacijo, predpostavljaj da je na koncu
    
 >   1. r-metrika (https://www.pnas.org/content/101/30/10955)
 >   1. varianca

> 1. Izriši grafe:
 >   aplituda, perioda, usklajenost(sinh) glede na spremenljivko (difuzija, gostota, veliksot prostora)

> dodatno: Razporejenost celic je edina, ki je random, zato jo prizemljimo na 1 razporeditev

>  Možni problemi
> * pri majhnih gostotah populacije je problem, da se mora upoštevati tudi čas potovanja "proteina", kar pomeni da lahko celice na veliki > razdalji sinhronizirano oscilirajo, vendar z časovnim razmikom
