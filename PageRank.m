function [R1 R2] = PageRank(nume, d, eps)
	% Calculeaza indicii PageRank pentru cele 3 cerinte
	% Scrie fisierul de iesire nume.out
  name=strcat(nume,".out");  
  fisintr=fopen(nume,"r");%Redeschiderea fisierului initial pentru citirea lui n si a lui val1, val2.
  line=fgetl(fisintr);
  n=str2num(line);
  fis=fopen(name,"w"); %Scriem in fisierul concatenat
  fprintf(fis,"%d\n",n);
  R1=Iterative(nume,d,eps);
  R2=Algebraic(nume,d);% R1, R2 vectorii calculati in iterative, respectiv algaebric
  garbage= fprintf(fis,"%.6f\n",R1);
  fprintf(fis,"\n");
  fprintf(fis,"%.6f\n",R2);

  for i=1:n
    garbage=fgetl(fisintr);% Citire inutila pentru a trece peste linie si a ajunge la val, respectiv val2
  endfor
  val1=fgetl(fisintr);
  val1=str2num(val1);
  val2=fgetl(fisintr);
  val2=str2num(val2);%Citire val1, val2
  v=zeros(n:1);
  for i=1:n
    v(i)=i; % Vector auxiliar pentru a retine pozitia initiala a elementelor sortate
  endfor
  sorted=1;
  while sorted==1
    sorted=0;
      for i=1:n-1
        if(R2(i)<R2(i+1))
          aux=R2(i);
          R2(i)=R2(i+1);
          R2(i+1)=aux;
          aux=v(i);
          v(i)=v(i+1);
          v(i+1)=aux;
          sorted=1;%Bubble sort, insa schimbam si v-ul deodata cu R2-ul.
        endif
      endfor
 
  endwhile 
  fprintf(fis,"\n");
  for i=1:n
    fprintf(fis,"%d %d %.6f\n",i,v(i), Apartenenta(R2(i),val1,val2));
  endfor
  fclose(fis);
endfunction