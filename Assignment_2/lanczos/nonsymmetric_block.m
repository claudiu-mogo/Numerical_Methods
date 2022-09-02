% in mod surprinzator, codul compileaza (este interpretat ca e octave)
% si chiar genereaza 2 blocuri, iar matricele din blocuri au forma spre ok

function [Vspace, Wspace]=nonsymmetric_block(A,V,W,m)
    
    % am considerat ca functia intoarce blocuri (notate space)
    % in timpul iteratiilor, vom lucra cu V_normal, V_tilda,
    % W_normal, W_tilda in felul urmator:
    % _act inseamna actual (iteratia j), iar _next inseamna (j+1)
    % la final le punem pe toate in bloc (space)
    
    V_tilda_next=zeros(size(V));
    W_tilda_next=zeros(size(W));
    [delta,beta]=qr(W'*V);
    V_normal_act=V*inv(beta);
    W_normal_act=W*delta;
    
    % initializare blocuri
    Vspace=[];
    Wspace=[];
    
    V_tilda_next=A*V_normal_act;
    W_tilda_next=A'*W_normal_act;
    
    % iteratiile in sine
    for j=1:m
        alfa=(W_normal_act)'*V_tilda_next;
        V_tilda_next=V_tilda_next-V_normal_act*alfa;
        W_tilda_next=W_tilda_next-W_normal_act*((alfa)');
        
        % QR decomposition pt V tilda si W tilda
        [V_normal_next,beta]=qr(V_tilda_next);
        [W_normal_next,delta]=qr(W_tilda_next);
        delta=delta';
        % SVD
        [U,sigma,Z]=svd((W_normal_next)'*V_normal_next);
        delta=delta*U*(sigma^(1/2));
        beta=(sigma^(1/2))*Z'*beta;
        V_normal_next=V_normal_next*Z*(sigma^(-1/2));
        W_normal_next=W_normal_next*U*(sigma^(-1/2));
        % adaugare in blocuri
        Vspace=[Vspace V_normal_next];
        Wspace=[Wspace W_normal_next];
        
        % pregatire iteratia urmatoare
        % j+2 va deveni j+1 pt V_tilda si W_tilda
        V_tilda_next=A*V_normal_next-V_normal_act*delta;
        W_tilda_next=A'*W_normal_next-W_normal_act*beta';
        % j+1-ul de acum va deveni j
        V_normal_act=V_normal_next;
        W_normal_act=W_normal_next;
    endfor
endfunction