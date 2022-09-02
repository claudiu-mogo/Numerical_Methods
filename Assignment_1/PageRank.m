function [R1, R2] = PageRank(nume, d, eps)
	% Calculeaza indicii PageRank pentru cele 3 cerinte
	% Scrie fisierul de iesire nume.out
    % generare nume fisier iesire
    outfile=[nume '.out'];
    f2=fopen(outfile,'w');
    % citire din fisier
    [A,val1,val2]=Citire(nume);
    % lansare algoritmi task 1 si 2
    R1=Iterative(nume,d,eps);
    R2=Algebraic(nume,d);
    % afisare primele 2 seturi de date
    s=size(A,1);
    fprintf(f2,"%d\n",s);
    fprintf(f2,"%.6f\n",R1);
    fprintf(f2,"\n");
    fprintf(f2,"%.6f\n",R2);
    fprintf(f2,"\n");
    % sortare descrescatoare R2
    R_sortat=sort(R2,'descend');
    % facem un vector caracteristic plin de 0
    % pt a vedea daca am luat deja elemntul de pe pozitia i
    caracteristic=zeros(s,1);
    % parcurgere pt a gasi match-uri intre vectorul sorat si cel normal
    for i=1:s
        for j=s:(-1):1
            % folosim o diferenta in abs pt a determina egalitatea
            if abs(R_sortat(i)-R2(j))<10^(-6)&&caracteristic(j)==0
                caracteristic(j)=1; % bifam drept element gasit
                fprintf(f2,"%d %d %.6f\n",i,j,Apartenenta(R_sortat(i),val1,val2));
                break
            end
        end
    end
    fclose(f2);
end