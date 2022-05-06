class Knapsack {
  int n;
  int c;
  boolean b[];
  
  int v[];
  int w[];
  
  Knapsack(int n, int c, int v[], int w[]) {
    this.n = n;
    this.c = c;
    this.v = v;
    this.w = w;
    
    b = new boolean[n];
  }
  
  int getValue() {
    int aux = 0;
    for (int i = 0; i < n; i++)
      if (b[i])
        aux += v[i];
       
    return aux;
  }
  
  int getWeight() {
    int aux = 0;
    for (int i = 0; i < n; i++)
      if (b[i])
        aux += w[i];
    return aux;
  }
}
