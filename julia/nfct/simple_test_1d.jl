push!(LOAD_PATH, pwd())
using NFCT
using LinearAlgebra

println("1d NFCT Test")

# bandwidth
N = 50

#number of nodes
M = 100

#create plan
p = NFCTplan((N,),M)
#generate random nodes
A = rand(M).-0.5

#set nodes
p.x = A
#generate random Fourier coefficients
fhat = rand(N)

#set Fourier coefficients
p.fhat = fhat

#transform
println( "trafo time:" )
@time NFCT.trafo(p)

#get function values
f2 = p.f

#define Fourier matrix
F = [ cos(2*pi*k_l*x_j) for x_j in A, k_l in 0:N-1 ]

#multiply Fourier matrix with vector of Fourier coefficients
f1 = F*fhat

error_vector = f1-f2
E_2 = norm(error_vector)/norm(f1)
E_infty = norm(error_vector, Inf)/norm(fhat,1)
println( "E_2 error:" )
println( E_2 )
println( "E_infty error:" )
println( E_infty )

if ( E_2 >= 1e-8 ) || ( E_infty >= 1e-8 )
	error( "Errors are too large." )
end

#adjoint
println( "adjoint time:" )
@time NFCT.adjoint(p)

#get function values
f2 = p.fhat

#multiply Fourier matrix with vector of Fourier coefficients
f1 = F'*p.f

error_vector = f1-f2
E_2 = norm(error_vector)/norm(f1)
E_infty = norm(error_vector, Inf)/norm(fhat,1)
println( "E_2 error:" )
println( E_2 )
println( "E_infty error:" )
println( E_infty )

if ( E_2 >= 1e-8 ) || ( E_infty >= 1e-8 )
	error( "Errors are too large." )
end
