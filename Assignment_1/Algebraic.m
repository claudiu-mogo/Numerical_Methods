function R = Algebraic(nume, d)
	% Functia care calculeaza vectorul PageRank folosind varianta algebrica de calcul.
	% Intrari: 
	%	-> nume: numele fisierului de intrare;
	%	-> d: probabilitatea ca un anumit utilizator sa continue navigarea la o pagina urmatoare.
	% Iesiri:
	%	-> R: vectorul de PageRank-uri acordat pentru fiecare pagina.
    
    % citire din fisier
    [A,~,~]=Citire(nume);
    N=size(A,1);
    %punem 0 pe diagonala daca nu erau deja
    for i=1:N
        A(i,i)=0;
    end
    % L(i) -> cate link-uri ies din i
    L=zeros(1,N);
    for i=1:N
        L(i)=sum(A(i,:));
    end
    % declarare matrice de grade exterioare
    K=zeros(N,N);
    for i=1:N
        K(i,i)=L(i);
    end
    % generare matrice M de adiacenta
    K=PR_Inv(K);
    M=(K*A)';
    % I1 este vector de 1
    I1=ones(N,1);
    % am trecut la limita formula de la task1
    % si am adus R in partea stanga
    R=(1-d)/N.*PR_Inv(eye(size(A))-d*M)*I1;
end