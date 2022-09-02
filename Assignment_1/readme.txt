Mogodeanu_Claudiu_311CC_tema1_MN

! Pe langa cele 5 fisiere de baza, am mai inclus si o functie de Citire.
Altfel, toate cele 3 functii principale ar fi avut cod duplicat si am zis
ca nu este good practice sa las asa. Tema a fost realizata in Matlab, dar, 
din cate am testat, ar trebui sa poata rula ok si in Octave.

!! Algoritmul Gram-Schmidt modificat utilizat, din cadrul functiei PR_Inv,
a fost inspirat pe baza celui din laboratorul 3, 
adaptat pentru contextul actual. Am intrebat la curs daca avem voie, iar
raspunsul primit a fost: da, atat timp cat este scris acest lucru in readme.

!!! In cadrul functiei PageRank, am utilizat o structura mai dubioasa de
determinare a egalitatii: am cosiderat egalitate daca diferenta in modul a 2
valori este mai mica decat 10^(-6). Mi s-a raspuns pe forum ca este ok, dar,
daca se vor efectua teste pe alte grafuri mai mari si vor exista diferente de
valori pe la zecimale de ordin >7, exista posibilitatea sa nu afiseze
exact ordinea buna a indicilor din R2.

Readme-ul este capped la 80 de caractere

Timp de implementare: ~5-6 ore

Detaliere functii:

Citire.m:

Functia primeste ca parametru numele fisierului de intrare, se citeste in N
numarul de noduri din graf si se creeaza matricea de adiacenta.
Se face alternativ citire din fisier si bifare in matrice.
Dupa aceea, se citesc si valorile necesare pt cerinta 3.
Se intorc: matricea de adiacenta si cele 2 valori.

PR_Inv.m:

Am ales sa urmez indicatia si sa aplic algoritmul Gram_Schmidt modificat
o singura data. Algoritmul a fost preluat, in mare parte, din laborator.
Astfel, am descompus A=QR, Q ortogonala, R superior triunghiulara.
Coloanele lui Q reprezinta coloanele curente ale lui A normate.
Algoritmul acesta modifica, la fiecare iteratie, coloanele lui A de dupa
pasul curent i.
Mutam Q in partea dreapta (Q^(-1)=Q') si ramanem cu n sisteme superior
triunghiulare de ecuatii. (cate unul pentru fiecare coloana) R*xi=Q'*ei.
Sistemele se vor rezolva de jos in sus, putand de fiecare data scoate
elementul aferent liniei respective.
Rezultatul fiecarui sistem reprezinta cate o coloana din inversa cautata.
Am lasat vreo 2 warninguri pentru a sublinia initializarea unor vectori.
Nu interfereaza cu rezolvarea cerintei in vreun fel.

Iterative.m:

Se preia matricea de adiacenta cu ajutorul functiei de ciire. Se ignora
val1 si val2 momentan ( [A,~,~] ). N reprezinta nr de noduri din matrice.
Se zeroizeaza diagonala principala conform cerintei.
Vom utiliza 2 vectori de lungime N, R si R_ant, ce vor reprezenta pagerankurile
la momentul actual si la momentul anterior. Vom pune 1/N initial.
Ulterior, ne pregatim matricele ajutatoare pentru implementarea formulei.
L reprezinta un vector ce contine linkurile exterioare aferente nodurilor,
valori care vor fi utilizate la construirea matricei K (le punem pe diagonala)
Se inverseaza K si se creeaza matricea M.
Am numit I1 vectorul coloana de N elemente, continand doar elemente de 1.
Astfel fromula devine: R(t+1)=d*M*R(t)+((1-d)/N)*I1;
Realizam o iteratie pt a avea R si R_ant diferite si punem conditia de oprire
norm(R-R_ant)<=eps. Rezultatul, dupa niste iteratii, se afla in R_ant.

Algebraic.m:

Constructia matricelor A, K, M si a vectorilor I1 si L este aceeasi ca in cazul
algoritmului Iterative. Pentru a determina formula algebrica, am trecut la
limita formula iterativa deoarece rezultatul exact se poate obtine doar dupa
un numar infinit de iteratii. Astfel R(t+1)->R si R(t)->R
Am mutat ambii vectori R in aceeasi parte si am ramas cu formula din functie.
R=d*M*R+((1-d)/N)*I1;
<=> R*(eye(size(A)) - d*M)=((1-d)/N)*I1;
<=> R=(1-d)/N*inv(eye(size(A))-d*M)*I1;
Rezultatul este cel cautat.

Apartenenta.m:

Pentru ca functia ceruta sa fie continua, vom rezolva sistemul:
{ a*val1 +b=0
{ a*val2 +b=1,
de unde, a=1/(val2-val1) si b=(-1)*val1/(val2-val1).
Apoi vedem carui interval apartine x si intoarcem valoarea corspunzatoare.

PageRank.m:

De data aceasta, avem nevoie si de val1 si val2 din fisierul de intrare.
Se lanseaza in executie primele 2 task-uri si se afiseaza datele.
Sortam cel de-al doilea vector descrescator in R_sortat.
Deoarece exista posibilitatea de egalitate si rezultatele ar trebui
afisate descrescator in caz de egalitate (asa mi-am propus, cel putin),
am creat un vector caracteristic ce retine daca vreo valoare a fost deja
identificata si afisata.
Functia PR_Inv foloseste totusi destulde impartiri, asa ca exista unele
diferente (incepand cu a 17a zecimala in cazul meu) intre valori care ar fi
trebuit sa fie egale (si care dau egale cu inv). Asa ca am determinat 
egalitatea cu abs(R_sortat(i)-R2(j))<10^(-6) deoarece doar primele 6
zecimale vor fi afisate in contextul temei actuale.
Afisam pe rand indicele din vectorul sortat, cel din vectorul initial si
rezultatul functiei Apartenenta.