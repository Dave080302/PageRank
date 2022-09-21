function B = PR_Inv(A)
	% Functia care calculeaza inversa matricii A folosind factorizari Gram-Schmidt
	% A*(A^-1)=In=>QR(A^-1)=In=>R(A^-1)=Qt
  [n n] = size(A);
  Q=zeros(n,n);
  R=zeros(n,n);
  for i=1:n
    R(i,i)=norm(A(:,i));
    Q(:,i)=A(:,i)/R(i,i);
    for j=i+1:n
      R(i,j)=Q(:,i)'*A(:,j);
      A(:,j)=A(:,j)-Q(:,i)*R(i,j);
    endfor
  endfor%Factorizare QR folosind Gram-Schmidt modificat
  for i=1:n
    b=Q'(:,i);
    for j=n:-1:1
      sum=0;
      for k=j+1:n
        sum=sum+R(j,k)*B(k,i); 
      endfor
      B(j,i)=(b(j)-sum)/R(j,j);
    endfor%Calcul sistem superior triunghiular pentru fiecare coloana a matricei B(inversa matricei A).
  endfor
 endfunction