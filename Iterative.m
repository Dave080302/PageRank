function R = Iterative(nume, d, eps)
	% Functia care calculeaza matricea R folosind algoritmul iterativ.
	% Intrari:
	%	-> nume: numele fisierului din care se citeste;
	%	-> d: coeficentul d, adica probabilitatea ca un anumit navigator sa continue navigarea (0.85 in cele mai multe cazuri)
	%	-> eps: eruarea care apare in algoritm.
	% Iesiri:
	%	-> R: vectorul de PageRank-uri acordat pentru fiecare pagina.
  fis=fopen(nume,"r");
  n=fgetl(fis);
  n=str2num(n); %Din fisier linia este citita ca string
  A=zeros(n,n);
  L=zeros(n,1);
  R0=zeros(n,1);% Matrice aditionala pentru a tine minte R la pasul anterior
  R=zeros(n,1); 
  M=zeros(n,n);
 % toate matricele aditionale folosite pentru a calcula indicele PR
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
        M(i,j)=1/L(j);%Matricea M prezenta pe wikipedia la alg iterative
      endif
    endfor
  endfor
  disp(M);
  for i=1:n
    R(i)=1/n; %Initializarea vectorului R
  endfor
  while(norm(R-R0) > eps) % Conditia de oprire
    R0=R;
    R=d*M*R0+((1-d)/n)*onematrix;% Formula de calcul de pe wikipedia
  endwhile
endfunction
