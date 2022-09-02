% consideram indicele s primit ca input (nu se obtine de-a lungul functiei)

function [A_m,B_m,C_m]=adaptive_order_rational(A,B,C,tol,sigma1,sigma2,s)
  
    % Cum H=C*inv(s*I_n-A)*B, deducem ca A este patratica de dim n, iar,
    % daca H are p linii, atunci si C are p linii
    p=size(C,1);
    n=size(A,1);
    H_anterior=eye(p);
    epsilon=1;
    m=1;
    % formam vectorul de sigma
    sigma=[sigma1 sigma2];
    % iteratii
    while(epsilon>tol)
        [Vm,Wm]=rational_block_lanczos(A,B,C,sigma);
        A_m=Wm'*A*Vm;
        B_m=Wm'*B;
        C_m=C*Vm;
        H_m=C_m*inv(s*eye(n)-A_m)*B_m;
        epsilon=norm(H_m-H_anterior,Inf);
        % facem pregatiri pt iteratia urmatoare
        m=m+1;
        H_anterior=H_m;
endfunction