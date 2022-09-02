function R = Iterative(nume, d, eps)
	% Functia care calculeaza vectorul R folosind algoritmul iterativ.
	% Intrari:
	%	-> nume: numele fisierului din care se citeste;
	%	-> d: coeficentul d, adica probabilitatea ca un anumit navigator sa continue navigarea (0.85 in cele mai multe cazuri)
	%	-> eps: eroarea care apare in algoritm.
	% Iesiri:
	%	-> R: vectorul de PageRank-uri acordat pentru fiecare pagina.
    
    % citire matrice
    [A,~,~]=Citire(nume);
    % aflam dimensiunea matricei
    N=size(A,1);
    % R->vector coloana la iteratia curenta
    R=zeros(1,N)';
    % R_ant->vector coloana la iteratia anterioara
    R_ant=zeros(1,N)';
    % initializare vectori de pagerank
    for i=1:N
        R_ant(i,1)=1/N;
        R(i,1)=1/N;
    end
    % punem 0 pe diagonala daca nu erau deja
    for i=1:N
        A(i,i)=0;
    end
    % generam vectorul de linkuri L
    L=zeros(1,N);
    for i=1:N
        L(i)=sum(A(i,:));
    end
    % formam matricea K
    K=zeros(N,N);
    for i=1:N
        K(i,i)=L(i);
    end
    % avem nevoie de de K^(-1)
    K=PR_Inv(K);
    M=(K*A)';
    % formare vector de 1
    I1=ones(N,1);
    % o prima iteratie
    R=d*M*R_ant+((1-d)/N)*I1;
    % verificare conditie + iteratia urmatoare
    while (norm(R-R_ant)>eps)
        R_ant=R;
        R=d*M*R_ant+((1-d)/N)*I1;
    end
    % ne ducem cu un pas in spate
    R=R_ant;
end