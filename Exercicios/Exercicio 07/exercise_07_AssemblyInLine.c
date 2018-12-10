// Para compilar: gcc exercise_07_AssemblyInLine.c -o modified
// Para executar: time ./modified

#include <stdio.h>
float ScalarProduct( float* a1, float* a2, int n ) {
      float ans = 0.0, temp1, temp2;
      register int i;
      for( i = 0; i < n; ++i ){
	 temp1 = a1[i];
     	 temp2 = a2[i]; 
	 asm("flds %1;"
	     "fmuls %2;"
	     "fadds %0;"
	     "fstps %0;"
	       : "=m" (ans)
	       : "g" (temp1), "g" (temp2)
	 );
      }
      return(ans);	      
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
