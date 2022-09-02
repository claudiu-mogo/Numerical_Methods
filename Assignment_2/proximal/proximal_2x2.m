function out = proximal_2x2(f, STEP = 0.1)
    % ===================================================================================
    % Aplica Interpolare Proximala pe imaginea 2 x 2 f cu puncte intermediare echidistante.
    % f are valori cunoscute în punctele (1, 1), (1, 2), (2, 1) ?i (2, 2).
    % Parametrii:
    % - f = imaginea ce se va interpola;
    % - STEP = distan?a dintre dou? puncte succesive.
    % ===================================================================================
    
    % TODO: Defineste coordonatele x si y ale punctelor intermediare.
    
    % folosim linspace pt a avea puncte egal departate
    x_inter=zeros((2-1)/STEP,1);
    x_inter=linspace(1,2,length(x_inter)+1);
    y_inter=zeros((2-1)/STEP,1);
    y_inter=linspace(1,2,length(y_inter)+1);
    % Se afl? num?rul de puncte.
    n = length(x_inter);

    % TODO: Cele 4 puncte încadratoare vor fi aceleasi pentru toate punctele din interior.
    x1=y1=1;
    x2=y2=2;

    % TODO: Initializeaza rezultatul cu o matrice nula n x n.
    out=zeros(n);
  
    % Se parcurge fiecare pixel din imaginea finala.
    for i = 1 : n
        for j = 1 : n
            % TODO: Afla cel mai apropiat pixel din imaginea initiala.
            
            % vedem daca e mai aproape de x1 sau de x2
            if((x_inter(i)-x1)<(x2-x_inter(i)))
              x_momentan=x1;
            else
              x_momentan=x2;
            endif
            
            % vedem daca e mai aproape de y1 sau de y2
            if((y_inter(j)-y1)<(y2-y_inter(j)))
              y_momentan=y1;
            else
              y_momentan=y2;
            endif
            % TODO: Calculeaza pixelul din imaginea finala.
            out(i,j)=f(x_momentan,y_momentan);
        endfor
    endfor

endfunction