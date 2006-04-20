function f=fastsum(x,alpha,y,kernel,c,m,n,p)

% f=fastsum(x,alpha,y,kernel,c,m,n,p)
%
%   Computes the sums
%
%     f(y_j) = sum_{k=1}^N alpha_k kernel(x_k-y_j)   (j=1:M)
%
%   by calling C-program with the fast NFFT-based algorithm.
%
%   size(f) = [N,1] (complex)
%   size(x) = [N,d]
%   size(alpha) = [N,1] (complex)
%   size(y)=[M,d]
%   kernel = 'multiquadric', e.g.
%   c kernel parameter
%   m cut-off parameter for NFFT
%   n expansion degree
%   p smoothness
%
% Markus Fenn, 2006.

[N,d]=size(x);
[M,d]=size(y);

%write input to file
save -ascii -double x.dat x
alpha2=[real(alpha) imag(alpha)];
save -ascii -double alpha.dat alpha2
save -ascii -double y.dat y

%execute C-program for fast summation
system(sprintf('./fastsum_matlab %d %d %d %d %d %d %s %e',d,N,M,n,m,p,kernel,c));

%read result from file
f2=load('f.dat');

f=f2(:,1)+i*f2(:,2);
