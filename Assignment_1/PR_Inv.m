function B = PR_Inv(A)
	% Functia care calculeaza inversa matricii A folosind factorizari Gram-Schmidt
	% Algoritmul este descris pe parcurs, la fiecare pas, dar ca principiu:
    % intai vom face gram-schmidt modificat o singura data pt A, aflam QR
    % si din relatia Q*R*B=I, mutam in R*B=Q*I, unde B este inversa
    % iar apoi rezolvam cele n sisteme superior 
    % triunghiulare rezultate (cate unul pt fiecare coloana)
    % initializam cu 0 Q,R si cate un vector coloana din a si q
    Q=zeros(size(A));
    R=zeros(size(A));
    n=size(A,1);
    % aplicam gram-schmidt modificat, invatat la laborator
    coloana_q=zeros(n,1)';
    coloana_a=zeros(n,1)';
    % Algoritmul gram-schmidt modificat face ca toate coloanele de dupa 
    % punctul actual sa fie ortogonale pe cea curenta
    for i=1:n
        coloana_a=A(:,i);
        R(i,i)=norm(coloana_a,2);
        % se normeaza coloana lui a
        coloana_q=coloana_a/R(i,i);
        for j=i+1:n
            R(i,j)=coloana_q' * A(:,j);
            A(:,j)=A(:,j)-coloana_q*R(i,j);
        end
        %adaugam pe rand coloane in Q
        Q(:,i)=coloana_q;
    end
    % mutam din QR*inv=I in partea dreapta astfel incat
    % Fie inversa definita prin coloane de tip x => R*xi=Q'*ei
    % xi sunt coloanele din B (ce vrem sa aflam),
    % iar Q'*I(n) va fi notata cu Trm
    Q=Q';
    Trm=Q*eye(n);
    B=zeros(size(A));
    %rezolvam n sisteme (cate unul pt fiecare coloana)
    %sistemul e superior triunghiular
    for k=1:n
        %luam fiecare element din coloana de la coada
        for i=n:-1:1
            sumR=0;
            for j=i+1:n
                %aflam partea din linie ocupata de necunoscutele anterioare
                sumR=sumR+R(i,j)*B(j,k);
            end
            %mutam in dreapta restul termenilor si impartim la coeficient
            B(i,k)=(Trm(i,k)-sumR)/R(i,i);
        end
    end
end