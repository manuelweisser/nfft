push!(LOAD_PATH, "/home/home/documents/nfft/julia/fastsum")
using fastsum
using LinearAlgebra

println("1d fastsum test")



 N = 2000;
 M = 2000;
 kernel = "multiquadric";
 c = (1/sqrt(N),3.5);
 #cv = collect(c)
 m = 4;
 p = 3;
 n = 156;
 eps_I = p/n;
 eps_B = 1/16;
 a = 5;
#const libe =  "/home/home/documents/nfft/julia/fastsum/libfastsumjulia.so"
#ptr = ccall(("jfastsum_alloc", libe), Ptr{fastsum_plan}, ())
  pt = fastsumplan(N,M,n,m,p,kernel,c,eps_I,eps_B)
