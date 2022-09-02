function [Ix, Iy, Ixy] = precalc_d(I)
    % =========================================================================
    % Prealculeaza matricile Ix, Iy si Ixy ce contin derivatele dx, dy, dxy ale 
    % imaginii I pentru fiecare pixel al acesteia.
    % =========================================================================
    
    % Obtinem dimensiunea imaginii.
    [m n nr_colors] = size(I);
    
    % TODO: Tranforma matricea I in double.
    I=double(I);
    
    % matricele sunt initializate cu 0 pt a avea 0 la capetele intervalelor
    % TODO: Calculeaza matricea cu derivate fata de x Ix.
    Ix=zeros(m,n);
    for i=1:m
      for j=2:n-1
        Ix(i,j)=fx(I,j,i);
      endfor
    endfor
    % TODO: Calculeaza matricea cu derivate fata de y Iy.
    Iy=zeros(m,n);
    for i=2:m-1
      for j=1:n
        Iy(i,j)=fy(I,j,i);
      endfor
    endfor
    % TODO: Calculeaza matricea cu derivate fata de xy Ixy.
    Ixy=zeros(m,n);
    for i=2:m-1
      for j=2:n-1
        Ixy(i,j)=fxy(I,j,i);
      endfor
    endfor
endfunction
