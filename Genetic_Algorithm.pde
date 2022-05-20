class GA {
  int n;
  float r;
  float k;
  
  ArrayList<Knapsack> Population;
  
  GA () {
    Population = new ArrayList<Knapsack>();
    
  }
  
  
  void nextGen() {
    ArrayList<Knapsack> newP = new ArrayList<Knapsack>();
    
    for (int i = 0; i < (int)(n * (1 - k)); i++) {
      Knapsack p1 = Population.get((int)random(0, n));
      Knapsack p2 = Population.get((int)random(0, n));
      
      Knapsack c = new Knapsack(p1.n, p1.c, p1.v, p1.w);
      
      for (int j = 0; j < p1.n; j++) {
        if (random(0, 1) >= .5)
          c.b[j] = p1.b[j];
        else
          c.b[j] = p2.b[j];
          
        if (random(0, 1) <= r)
          c.b[j] = !c.b[j];
      }
      
      newP.add(c);
    }
    
    for (int i = (int)(n * (1 - k)); i < n; i++) {
      newP.add(Population.get(i));
    }
  }
}
