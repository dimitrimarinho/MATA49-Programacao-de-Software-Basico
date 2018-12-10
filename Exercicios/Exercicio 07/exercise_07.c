// Para compilar: gcc exercise_07.c -o notModified
// Para executar: time ./notModified

#include <stdio.h>
float ScalarProduct( float* a1, float* a2, int n ) {
      float ans = 0.0;
      register int i;
      for( i = 0; i < n; ++i )
      ans += a1[i] * a2[i];
      return( ans );
}
int main(){

      float a1[10], a2[10];
      register int i, j;
      for( i = 0; i < 10; i++ ){
          a1[i] = i + 28;
          a2[i] = i + 23;
      }
      for( j = 0; j < 100000000; j++ )
          ScalarProduct(a1, a2, 10);

      return 0;
}
