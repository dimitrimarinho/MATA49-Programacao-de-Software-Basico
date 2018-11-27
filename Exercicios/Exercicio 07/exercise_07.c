// Para compilar: gcc exercise_07.c -o exercise_07
// Para executar: time ./exercise_07

#include <stdio.h>
float ScalarProduct( float* a1, float* a2, int n ) {
      float ans = 0.0;
      register int i;
      for( i = 0; i < n; ++i )
      ans += a1[i] * a2[i];
      return( ans );
}
int main(){

      int n;
      scanf("%d", &n);
      float a1[n], a2[n];
      register int i, j;
      for( i = 0; i < n; i++ ){
          a1[i] = i + 28;
          a2[i] = i + 23;
      }
      for( j = 0; j < 99999999; j++ )
          ScalarProduct( a1, a2, n );

      return 0;
}
