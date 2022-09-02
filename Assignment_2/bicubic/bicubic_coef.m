function A = bicubic_coef(f, Ix, Iy, Ixy, x1, y1, x2, y2)
    % =========================================================================
    % Calculeaz? coeficien?ii de Interpolare Bicubic? pentru 4 puncte al?turate
    % =========================================================================

    % TODO: Calculeaz? matricile intermediare.
    
    mat1=zeros(4);
    mat2=zeros(4);
    deriv=zeros(4);
    % luam matricele din cerinta
    mat1=[1 0 0 0; 1 1 1 1; 0 1 0 0; 0 1 2 3];
    mat2=[1 1 0 0; 0 1 1 1; 0 1 0 2; 0 1 0 3];
    % inversare matrice
    mat1_inv=inv(mat1);
    mat2_inv=inv(mat2);
    % generare matrice de derivate patiale
    deriv=[f(y1,x1) f(y2,x1) Iy(y1,x1) Iy(y2,x1)
           f(y1,x2) f(y2,x2) Iy(y1,x2) Iy(y2,x2)
           Ix(y1,x1) Ix(y2,x1) Ixy(y1,x1) Ixy(y2,x1)
           Ix(y1,x2) Ix(y2,x2) Ixy(y1,x2) Ixy(y2,x2)];
    % TODO: Converte?te matricile intermediare la double.
    mat1_inv=double(mat1_inv);
    mat2_inv=double(mat2_inv);
    deriv=double(deriv);
    % TODO: Calculeaz? matricea final?.
    A=mat1_inv*deriv*mat2_inv;
endfunction