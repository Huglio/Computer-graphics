class KnapsackProblem {
  int n;
  int value[];
  int weight[];
  
  int capacity;
  
  KnapsackProblem(int n, int c) {
    this.n = n;
    value = new int[n];
    for (int i = 0; i < n; i++)
      value[i] = int(random(10, 30));
    weight = new int[n];
    for (int i = 0; i < n; i++)
      weight[i] = int(random(20, 30));
    
    capacity = c;
  }
  
  
}

class GA {
  int n;
  float r, k;
  Subject Population[];
  KnapsackProblem KP;
  
  GA (int n, float r, float k, KnapsackProblem KP) {
    this.n = n;
    this.r = r;
    this.k = k;
    this.KP = KP;
    
    Population = new Subject[n];
    
    for (int i = 0; i < n; i++)
      Population[i] = new Subject(KP.n);
  }
  
  void Test () {
    println(n);
  }
}

class  Subject {
  int n;
  boolean knapsack[];
  
  Subject (int n){
    this.n = n;
    knapsack = new boolean[n];
    
    for (int i = 0; i < n; i++) {
      if (random(0, 1) >= .5)
        knapsack[i] = true;
      else
        knapsack[i] = false;
    }
  }
  
  Subject (Subject a, Subject b) {
    n = a.knapsack.length;
    knapsack = new boolean[n];
    
    for (int i = 0; i < n; i++) {
      if (random(0, 1) >= 0.5)
        knapsack[i] = a.knapsack[i];
      else
        knapsack[i] = b.knapsack[i];
    }
  }
}

GA ga;
void setup() {
  size(500, 500);
  ga = new GA(1000, .2, .15, new KnapsackProblem(20, 50));
}

void draw() {
  background(0);
  
}

void RunGa() {
  
}
