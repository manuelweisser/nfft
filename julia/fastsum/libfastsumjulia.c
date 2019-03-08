#include "config.h"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#ifdef HAVE_COMPLEX_H
  #include <complex.h>
#endif

#ifdef _OPENMP
  #include <omp.h>
#endif

#include "fastsum.h"
#include "kernels.h"
#include "infft.h"



fastsum_plan* jfastsum_alloc(){
  fastsum_plan* p = nfft_malloc(sizeof(fastsum_plan));
  return p;
}
// c wird von Julia als Float64-Pointer übergeben

void jfastsum_init(fastsum_plan* fp,int D,int N,int M,char* s,R* c,int n,int m,int p,float eps_I,float eps_B ){
  C (*kernel)(R, int, const R *);

  if (strcmp(s, "gaussian") == 0)
    kernel = gaussian;
  else if (strcmp(s, "multiquadric") == 0)
    kernel = multiquadric;
  else if (strcmp(s, "inverse_multiquadric") == 0)
    kernel = inverse_multiquadric;
  else if (strcmp(s, "logarithm") == 0)
    kernel = logarithm;
  else if (strcmp(s, "thinplate_spline") == 0)
    kernel = thinplate_spline;
  else if (strcmp(s, "one_over_square") == 0)
    kernel = one_over_square;
  else if (strcmp(s, "one_over_modulus") == 0)
    kernel = one_over_modulus;
  else if (strcmp(s, "one_over_x") == 0)
    kernel = one_over_x;
  else if (strcmp(s, "inverse_multiquadric3") == 0)
    kernel = inverse_multiquadric3;
  else if (strcmp(s, "sinc_kernel") == 0)
    kernel = sinc_kernel;
  else if (strcmp(s, "cosc") == 0)
    kernel = cosc;
  else if (strcmp(s, "cot") == 0)
    kernel = kcot;
  else if (strcmp(s, "one_over_cube") == 0)
    kernel = one_over_cube;
  else if (strcmp(s, "log_sin") == 0)
    kernel = log_sin;
  else if (strcmp(s, "laplacian_rbf") == 0)
    kernel = laplacian_rbf;
  else
  {
    s = "multiquadric";
    kernel = multiquadric;
  }

  fastsum_init_guru(fp,D,N,M,kernel,c,0,n,m,p,eps_I,eps_B);
}

double _Complex* jfastsum_set_x(fastsum_plan* fp, double _Complex* x){
  int N = fp -> N_total;
  int k;
  for (k=0; k<N; k++)
    fp -> x[k] = x[k];
  return fp->x;
}

double _Complex* jfastsum_set_y(fastsum_plan* fp, double _Complex* y){
  int M = fp -> M_total;
  int k;
  for (k=0; k<M; k++)
    fp -> y[k] = y[k];
  return fp->y;
}

double _Complex* jfastsum_set_alpha(fastsum_plan* fp, double _Complex* alpha){
  int N = fp -> N_total;
  int k;
  for (k=0; k<N; k++)
    fp -> alpha[k] = alpha[k];
  return fp->y;
}


double _Complex* jfastsum_trafo(fastsum_plan* fp){
  fastsum_trafo(fp);
  return fp -> f;
}

void jfastsum_finalize(fastsum_plan* fp){
  fastsum_finalize(fp);
  return;
}
