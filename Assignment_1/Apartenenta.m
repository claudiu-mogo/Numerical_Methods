function y = Apartenenta(x, val1, val2)
	% Functia care primeste ca parametrii x, val1, val2 si care calculeaza valoarea functiei membru in punctul x.
	% Stim ca 0 <= x <= 1
    % se rezolva sistemul cu necunoscutele a si b:
    % { a*val1 +b=0
    % { a*val2 +b=1
    a=1/(val2-val1);
    b=(-1)*val1/(val2-val1);
    % verificare apartenenta interval
    if x>val2
        y=1;
    elseif x<val1
        y=0;
    else
        y=a*x+b;
    end
end