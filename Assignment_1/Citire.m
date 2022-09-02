function [A, val1, val2] = Citire(nume)
    % functie care citeste datele din fisier 
    f1=fopen(nume,'r');
    N=fscanf(f1,"%d",1);
    % initializare mat de adiacenta cu 0. Daca nu punem valoare, ramane 0
    A=zeros(N,N);
    % citire si creare mat de adiacenta
    % pag->pagina actuala, nr_link->ordinul exterior, pag2-> vecini
    for i=1:N
        pag=fscanf(f1,"%d",1);
        nr_link=fscanf(f1,"%d",1);
        for j=1:nr_link
            pag2=fscanf(f1,"%d",1);
            A(pag,pag2)=1;
        end
    end
    %citire valori pt Apartenenta
    val1=fscanf(f1,"%f",1);
    val2=fscanf(f1,"%f",1);
end

