function [Vend, Wend]=rational_block(A,B,C,sigma)
  
    % sigma este vector de sigma-uri
    % functia intoarce 2 blocuri
    % vom lucra, ca la exercitiul anterior, cu iteratie curenta si urmatoare.
    % _k inseamna iteratie curenta (k), iar _next inseamna (k+1)
     
    [n,p]=size(A);
    % noi primim ca input Ct, deci transpunem pt a avea C normal
    C=C';
    % S0 si R0
    S=inv((A-sigma(1)*eye(n)))*B;
    R=inv((A-sigma(1)*eye(n))')*C';
    
    % judecand dupa liniile 12 si 22 din codul din pdf, trebuie qr
    [V_k,H0]=qr(S);
    [W_k,G0]=qr(R);
    % initializare blocuri
    Vend=[V_k];
    Wend=[W_k];
    
    m=length(sigma);
    % iteratiile in sine
    for k=1:m
        if(k<m)
            if(sigma(k+1)==Inf)
                S_k=A*V_k;
                R_k=A'*W_k;
            else
                S_k=inv((A-sigma(k+1)*eye(n)))*V_k;
                R_k=inv((A-sigma(k+1)*eye(n))')*W_k;
            endif
            
            % calculare matrice S si R curente
            H_k=W_k'*S_k;
            G_k=V_k'*R_k;
            S_k=S_k-V_k*H_k;
            R_k=R_k-W_k*G_k;
            
            % facem QR si SVD
            [V_next,H_next]=qr(S_k);
            [W_next,G_next]=qr(R_k);
            [P,D,Q]=svd(W_next'*V_next);
            Q=Q';
            
            % generam matricele urmatoare
            V_next=V_next*Q*(D^(-1/2));
            W_next=W_next*P*(D^(-1/2));
            H_next=(D^(1/2))*Q'*H_next;
            G_next=(D^(1/2))*P'*G_next;
            
            % trecem la iteratia urmatoare
            V_k=V_next;
            W_k=W_next;
            % dam append la blocuri
            Vend=[Vend V_k];
            Wend=[Wend W_k];
        else
            if(sigma(m+1)==Inf)
                S_m=A*B;
                R_m=A'*C;
            else
                S_m=inv(A)*B;
                R_m=inv(A)'*C';
            endif
            % trecem de la iteratia anterioara
            % (ca va fi o trecere de la if normal la else-ul acesta)
            V_m=V_k;
            W_m=W_k;
            H_m=Wend'*S_m;
            G_m=Vend'*R_m;
            S_m=S_m-Vend*H_m;
            R_m=R_m-Wend*G_m;
            % qr si svd
            [V_next,H_next]=qr(S_m);
            [W_next,G_next]=qr(R_m);
            [P,D,Q]=svd(W_next'*V_next);
            Q=Q';
            % gasire matrice finale
            V_next=V_next*Q*(D^(-1/2));
            W_next=W_next*P*(D^(-1/2));
            H_next=(D^(1/2))*Q'*H_next;
            G_next=(D^(1/2))*P'*G_next;
            % append la blocuri
            Vend=[Vend V_next];
            Wend=[Wend W_next];
        endif
               
    endfor
    
    
endfunction