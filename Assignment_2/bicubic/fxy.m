function r = fxy(f, x, y)
    % =========================================================================
    % Aproximeaza derivata fata de x si y a lui f in punctul (x, y).
    % =========================================================================
    
    % TODO: Calculeaza derivata.
    
    % folosim una din formulele din pdf (cea de pe primul rand)
    r=(fy(f,x+1,y)-fy(f,x-1,y))/2;
endfunction