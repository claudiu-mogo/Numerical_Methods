Mogodeanu_Claudiu_311CC_tema2_MN

! Am implementat toate functiile cerute in cadrul tuturor task-urilor.
Pe statia locala obtin punctaj maxim atat pe task 1, cat si pe task 2.
In cazul task-ului 3, am implementat, pe cat de logic am putut, toate cele
3 functii. Unele intorc date destul de apropiate de adevar.

Readme-ul este capped la 80-85 de caractere.
Timp de implementare: ~12h

Task 1 - proximal

Acest task a pus cate ceva probleme deoarece mai existau instante in care
functiile primeau argumentele in ordine neintuitiva.

proximal_2x2: Am utilizat functia linspace pt a face elemente egal departate,
afland anterior numarul de puncte din interval. Cum, intotdeauna, punctele
intermediare (notate x/y_inter(k)) se vor afla mereu intre x1 si x2, aflam de
care este mai apropiat fiecare punct comparand distantele fata de capete:
if((x_inter(i)-x1)<(x2-x_inter(i))).

proximal_resize: Facem resize cu (q-1)/(n-1) pentru a ajunge unde trebuie in patrat.
Matricea de transformare este diagonala, asa ca o inversam punand 1/element
in locul element-ului de pe diagonala. Structura rem(floor(y_p*10),10) intoarce
prima zecimala a numarului. O comparam cu 5 pt a vedea in ce parte rotunjim.
La final, punem in matricea R un pixel din I.

proximal_rotate: La aceasta functie am stat cel mai mult din toata tema. Imi dadea
constant eroare ca incercam sa inversez o matrice singulara. Asa ca am luat
separat cazurile pt care liniile sunt egale 2 cate 2. Astfel, stiam automat cate o
coordonata (variabila care dadea egalitatea) si aflam pixelul doar in functie de
cealalta coordonata, facand medie ponderata.
Daca matricea nu avea determinantul 0, o puteam inversa in functia de coef.

proximal_coef: Am construit matricele si am dus practic matricea A in partea dreapta
a egalului din relatia A*a=b; Stim ca A se poate inversa.

functiile RGB: am initializat si construit fiecare canal. La final am utilizat
functia predefinita cat pentru a le uni pe cea de-a treia dimensiune.

Task 2- bicubic

calcul derivate partiale: am folosit efectiv formulele din pdf. La derivata mixta
am folosit formula de pe primul rand (cea cu 2 termeni), nu cea cu 4.

precalc_d: Doar am construit matricele de derivate partiale pe baza functiilor
aflate anterior. Am considerat functia "f" din derivate ca fiind imaginea I.

bicubic_coef: Avem nevoie de 3 matrice intermediare: 2 provenite din sistemul de
ecuatii si una de derivate partiale. Toate sunt aceleasi din pdf. Am lucrat pe
forma initiala a sistemului, astfel incat am inversat primele 2 matrice intermediare
A contine coeficientii doriti.

bicubic_resize: s_x si s_y se aduc in intervalul bun prin intermediul aceleiasi
formule de la task 1: s_x=(q-1)/(n-1);	Matricea de transformare este tot diagonala,
deci o inversand punand 1/element in loc de element. Cand aflam punctele ce
inconjoara x,y, verificam daca este nr intreg (caz in care ceil ar fi egal cu floor)
si daca da index out of bounds (caz in care scalam la ultima valoare permisa m sau n).
Cand am pus datele in matricea R, am transpus intreaga formula din cerinta deoarece,
aici, axa y-lor este cea principala, urmand x-ii. Sincer, am incercat toate
combinatiile pana cand a creat o matrice R buna.

bicubic_resize_RGB: Aceleasi operatii ca la RGB-urile de la task 1.

Task 3 - lanczos

nonsymmetric_block: Am notat cele 2 blocuri cu Vspace si Wspace, initial nule, in
care vom adauga, pe parcursul fiecarei iteratii, cate o matrice.
Am lucrat doar cu iteratia curenta si iteratia urmatoare. Nu puteam da Matrice(j)
deoarece aceastra structura inseamna al j-lea element din Matrice, parcursa pe
coloane. Astfel, _act inseamna actual (iteratia j), iar _next inseamna (j+1).
In cadrul fiecarei iteratii, alipim cate o matrice la bloc:
Vspace=[Vspace V_normal_next];

rational_block_lanczos: Si aceasta functie intoarce blocuri, notate Vend si Wend.
sigma este un array de puncte de interpolare sigma. Am lucrat, ca la subpunctul
anterior, cu iteratie curenta si urmatoare. Astfel, _k inseamna iteratie
curenta (k), iar _next inseamna (k+1). Avand in vedere ca noua ni se dau m valori
sigma, nu inteleg ce sens are sa se compare sigma(m+1) cu Inf, dar m-am 
conformat pseudocodului din pdf. In rest, am urmat pasii
din pdf si cred ca e ok. In cadrul fiecarei iteratii, alipim cate o matrice la bloc:
Wend=[Wend W_k];

adaptive_order_rational: Am considerat indicele s din functia de transfer ca fiind
primit in input. Am facut asa deoarece nu se obtine de-a lungul functiei.
Algoritmul este destul de clar in sine. In plus fata de pseudocod, am lucrat tot
cu H_anterior si H_m (curent), actualizandu-le la finalul fiecarei iteratii.

