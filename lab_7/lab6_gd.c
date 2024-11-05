// lab6_gd.c
// George Davis gdavis@hmc.edu 10/22/24
#include <stdlib.h>    // for malloc

// Add two m x n matrices and get an m x n sum: Y = A + B
void add(int m, int n, double *A, double *B, double *Y) {
  int i, j;

  for (i = 0; i < m; i++) {
    for (j = 0; j < n; j++) {
      Y[j + i * n] = A[j + i * n] + B[j + i * n];
    }
  }
}

// Y = sa * A + sb * B
void linearcomb(int m, int n, double sa, double sb, double *A, double *B, double *Y) {
  int i, j;

  for (i = 0; i < m; i++) {
    for (j = 0; j < n; j++) { 
      Y[j + i * n] = sa * A[j + i * n] + sb * B[j + i * n];
    }
  }
}
// At = transpose(A). A is an m x n matrix, so At is an n x m matrix
void transpose(int m, int n, double *A, double *A_t) {
  int i, j;

  for (i = 0; i < m; i++) {
    for (j = 0; j < n; j++) {
      A_t[i + j * m] = A[j + i * n];
    }
  }
}

// return 1 if all elements of A are equal to the corresponding elements of B, 0 otherwise
int equal(int m, int n, double *A, double *B) {
  int i, j;

  for (i = 0; i < m; i++) {
    for (j = 0; j < n; j++) {
      if (A[j + i * n] != B[j + i * n]) return 0;
    }
  }
  return 1;
}

// Y = A * B
// A is m1 x n1m2. B is n1m2 x n2 Y is m1 x n2
void mult(int m1, int n1m2, int n2, double *A, double *B, double *Y) {
  int i, j, k;

  for (i = 0; i < m1; i++) {
    for (j = 0; j < n2; j++) {
      Y[j + i * n2 ] = 0;
    }
  }

  for (i = 0; i < m1; i++) {
    for (j = 0; j < n2; j++) {
      for (k = 0; k < n1m2; k++) {
        Y[j + i * n2] += A[k + i * n1m2] * B[j + k * n2];
      }
    }
  }
}

// The following functions and main() are provided for you
double *newMatrix(int m, int n) {
  double *mat;

  mat = (double *)malloc(m * n * sizeof(double));
  return mat;
}
double *newIdentityMatrix(int n) {
  double *mat = newMatrix(n, n);
  int i, j;

  for (i = 0; i < n; i++)
    for (j = 0; j < n; j++)
      mat[j + i * n] = (i == j);

  return mat;
}

double dotproduct(int n, double a[], double b[]) {
  volatile int i;
  double sum;
  for (i = 0; i < n; i++) {
    if (i == 0) sum = 0;
    sum += a[i] * b[i];
  }
  return sum;
}

int main(void) {
  double v1[3]       = {4, 2, 1};                      // 1x3 vector
  double v2[3]       = {1, -2, 3};                     // 1x3 vector
  double dp          = dotproduct(3, v1, v2);          // compute v1 dot v2
  double m1[9]       = {0, 0, 2, 0, 0, 0, 2, 0, 0};    // 3x3 matrix
  double *m2         = newIdentityMatrix(3);           // 3x3 identity matrix
  double *m3         = newMatrix(3, 3);                // 3x3 matrix
  double m4[6]       = {2, 3, 4, 5, 6, 7};             // 3x2 matrix
  double *m5         = newMatrix(3, 2);                // 3x2 matrix
  double m6[6]       = {6, 2, 5, 8, 2, 7};             // 2x3 matrix
  double *m7         = newMatrix(3, 2);                // 3x2 matrix
  double *m8         = newMatrix(3, 2);                // 3x2 matrix
  double expected[6] = {2, 1, 0, 1, 0, -1};            // expected result matrix
  int eq;

  add(3, 3, m1, m2, m3);                               // m3= m1+m2
  mult(3, 3, 2, m3, m4, m5);                           // m5= m3*m4 (3x2 result matrix)
  transpose(2, 3, m6, m7);                             // m7= m6^t
  linearcomb(3, 2, 1, 1 - dp, m5, m7, m8);             // m8= 1*m5 + (1-dp)*m7
  eq = equal(3, 2, m8, expected);                      // check if m8 is as expected

  return eq;                                           // return 1 if so; 0 otherwise
}