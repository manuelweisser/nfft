push!(LOAD_PATH, pwd())
using fastsum
using LinearAlgebra

println("2d fastsum test")

# set the parameters:
N = 2000;
M = 2000;
kernel = "multiquadric";
c = (1/sqrt(N),3.5);
m = 4;
p = 3;
n = 156;
eps_I = p/n;
eps_B = 1/16;
a = 5;

# create a Plan-Object in Julia
pt = fastsumplan(N,M,n,m,p,kernel,c,eps_I,eps_B);

# generate source nodes in circle of radius 0.25-eps_B/2
r = sqrt.(rand(N))*(0.25-eps_B/2);
phi = rand(N)*2*pi;
xhat = [r.*cos.(phi), r.*sin.(phi)];
xhat = Array{Float64}(undef,2,N);
pt.x = xhat;

# generate coefficients alpha_k
alpha_temp = rand(N)+im*rand(N);

pt.alpha = alpha_temp;

# generate target nodes in circle of radius 0.25-eps_B/2
r = sqrt.(rand(M))*(0.25-eps_B/2);
phi = rand(M)*2*pi;
y_temp = [r.*cos.(phi) r.*sin.(phi)];
y_temp = Array{Float64}(undef,2,M);
pt.y = y_temp;

# Start the Transformation
fastsum.trafo(pt);