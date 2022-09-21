function R = Algebraic(nume, d)
	% Functia care calculeaza vectorul PageRank folosind varianta algebrica de calcul.
	% Intrari: 
	%	-> nume: numele fisierului in care se scrie;
	%	-> d: probabilitatea ca un anumit utilizator sa continue navigarea la o pagina urmatoare.
	% Iesiri:
	%	-> R: vectorul de PageRank-uri acordat pentru fiecare pagina.
  fis=fopen(nume,"r");
  n=fgetl(fis);
  n=str2num(n); %Din fisier linia este citita ca string
  A=zeros(n,n);
  L=zeros(n,1);
  R0=zeros(n,1);% Matrice aditionala pentru a tine minte R la pasul anterior
  R=zeros(n,1); 
  M=zeros(n,n); % toate matricele aditionale folosite pentru a calcula indicele PR
  onematrix=ones(n,1);
  for i=1:n 
    str=fgetl(fis);
    str=str2num(str);
    [sz1 sz2]= size(str);
    for j=3:sz2
       if( A(i,str(1,j)) == 0 )
        A(i,str(1,j)) = 1;
        L(i)=L(i)+1;
       endif % Citirea direct ca linie este mai facila in cazul grafurilor
    endfor
  endfor
  for i=1:n
    for j=1:n
      if(A(j,i)==1)
        M(i,j)=1/L(j); %Initializarea matricei M
      endif
    endfor
  endfor
  Matrix=PR_Inv(eye(n)-d*M); %Algoritmul de inversare folosind Gram-Schmidt
  R=(1-d)/n*Matrix*onematrix; % Aplicarea formulei reiesita din calcul direct in ecuatia Pagerank
endfunction