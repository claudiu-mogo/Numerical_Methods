function R = proximal_rotate(I, rotation_angle)
    % =========================================================================
    % Roteste imaginea alb-negru I de dimensiune m x n cu unghiul rotation_angle,
    % aplicând Interpolare Proximala.
    % rotation_angle este exprimat în radiani.
    % =========================================================================
    [m n nr_colors] = size(I);
    
    % Se converteste imaginea de intrare la alb-negru, daca este cazul.
    if nr_colors > 1
        R = -1;
        return
    endif

    % Obs:
    % Atunci când se aplica o scalare, punctul (0, 0) al imaginii nu se va deplasa.
    % În Octave, pixelii imaginilor sunt indexati de la 1 la n.
    % Daca se lucreaza în indici de la 1 la n si se inmultesc x si y cu s_x respectiv s_y,
    % atunci originea imaginii se va deplasa de la (1, 1) la (sx, sy)!
    % De aceea, trebuie lucrat cu indici în intervalul [0, n - 1].

    % TODO: Calculeaza cosinus si sinus de rotation_angle.
    cosinus=cos(rotation_angle);
    sinus=sin(rotation_angle);
    % TODO: Initializeaza matricea finala.
    R=zeros(m,n);
    % TODO: Calculeaza matricea de transformare.
    Trot=zeros(2);
    Trot=[cosinus (-1)*sinus
          sinus cosinus];
    % TODO: Inverseaza matricea de transformare, FOLOSIND doar functii predefinite!
    Trot_inv=inv(Trot);
    % Se parcurge fiecare pixel din imagine.
    for y = 0 : m - 1
        for x = 0 : n - 1
            % TODO: Aplica transformarea inversa asupra (x, y) si calculeaza x_p si y_p
            % din spatiul imaginii initiale.
            vect=[x,y]';
            vect2=Trot_inv*vect;
            x_p=vect2(1);
            y_p=vect2(2);
            % TODO: Trece (xp, yp) din sistemul de coordonate [0, n - 1] în
            % sistemul de coordonate [1, n] pentru a aplica interpolarea.
            x_p=x_p+1;
            y_p=y_p+1;
            % TODO: Daca xp sau yp se afla în exteriorul imaginii,
            % se pune un pixel negru si se trece mai departe.
            
            % verificam pe rand pt fiecare axa
            if(x_p>n||x_p<1)
              R(y+1,x+1)=0;
              continue;
            endif
            if(y_p>m||y_p<1)
              R(y+1,x+1)=0;
              continue;
            endif
            % TODO: Afla punctele ce înconjoara(xp, yp).
            x1=floor(x_p);
            x2=ceil(x_p);
            y1=floor(y_p);
            y2=ceil(y_p);
            % TODO: Calculeaza coeficientii de interpolare notati cu a
            % Obs: Se poate folosi o functie auxiliara în care sau se calculeze coeficientii,
            % conform formulei.
            
            % daca facem cu inversa, trebuie sa vedem daca avem matrice singulara
            % sau nu (mi-am dat seama de asta pt ca imi apareau niste warninguri).
            % adica daca determinantul e 0 (adica linii proportionale sau egale).
            % asta se intampla daca cel putin o pereche {x1,x2} sau {y1,y2} are
            % elemente egale (adica x_p sau y_p sunt intregi)
            
            % astfel, stim o coordonata (sau pe amandoua)
            % si o aflam pe cealalta cu medie ponderata
            if (y1==y_p&&x1==x_p)
              R(y+1,x+1)=I(y_p,x_p);
            elseif (y1==y_p)  % punctul se afla doar intre x-uri (facem medie ponderata)
              dist1=x2-x_p;
              dist2=x_p-x1;
              medie_ponderata=(dist1*I(y_p,x1)+dist2*I(y_p,x2))/(dist1+dist2);
              R(y+1,x+1)=medie_ponderata;
            elseif (x1==x_p)
              dist1=y2-y_p;
              dist2=y_p-y1;
              medie_ponderata=(dist1*I(y1,x_p)+dist2*I(y2,x_p))/(dist1+dist2);
              R(y+1,x+1)=medie_ponderata;
            else
              vect3=proximal_coef(I,x1,y1,x2,y2);
              % TODO: Calculeaza valoarea interpolata a pixelului (x, y).
              % folosim formula data in pdf
              R(y+1,x+1)=vect3(1)+vect3(2)*x_p+vect3(3)*y_p+vect3(4)*x_p*y_p;
            endif
        endfor
    endfor

    % TODO: Transforma matricea rezultata în uint8 pentru a fi o imagine valida.
    R=uint8(R);
    
endfunction
