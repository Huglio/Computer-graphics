import java.util.*;

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
  
  boolean isValid(boolean knapsack[]) {
    
    int aux = 0;
    for (int i = 0; i < n; i++) {
      if (knapsack[i])
        aux += weight[i];
    }
    
    return aux <= capacity;
  }
  
  int getValue(boolean knapsack[]) {
    
    int aux = 0;
    for (int i = 0; i < n; i++) {
      if (knapsack[i])
        aux += value[i];
    }
    
    return aux;
  }
  
  int getWeight (boolean knapsack[]) {
    int aux = 0;
    for (int i = 0; i < n; i++) {
      if (knapsack[i])
        aux += weight[i];
    }
    
    return aux;
  }
}

class GA {
  int n;
  int generation;
  float r, k;
  ArrayList<Subject> Population;
  KnapsackProblem KP;
  
  GA (int n, float r, float k, KnapsackProblem KP) {
    this.n = n;
    this.r = r;
    this.k = k;
    this.KP = KP;
    generation = 0;
    
    Population = new ArrayList<Subject>();
    
    for (int i = 0; i < n; i++)
      Population.add(new Subject(KP));
  }
  
  void RunGen() {
    Collections.sort(Population);
    
    ArrayList<Subject> newPopulation = new ArrayList<Subject> ();
    
    for (int i = 0; i < (int)(n * (1 - k)); i++) {
      newPopulation.add(new Subject(Population.get((int)random(0, n)), Population.get((int)random(0, n))));
      newPopulation.get(i).mutate(k);
    }
    
    for (int i = (int)(n * (1 - k)); i < n; i++) {
      newPopulation.add(Population.get(i));
    }
    
    if (Population.get(n - 1) == newPopulation.get(n - 1))
      println("ahhhhhhhhhhhhh");
    
    Population = newPopulation;
    generation++;
  }
}

class Subject  implements Comparable<Subject> {
  int n;
  KnapsackProblem KP;
  boolean knapsack[];
  
  Subject (KnapsackProblem KP){
    this.KP = KP;
    this.n = KP.n;
    knapsack = new boolean[n];
    
    for (int i = 0; i < n; i++) {
      if (random(0, 1) >= .5)
        knapsack[i] = true;
      else
        knapsack[i] = false;
    }
  }
  
  Subject (Subject a, Subject b) {
    n = a.n;
    this.KP = a.KP;
    knapsack = new boolean[n];
    
    for (int i = 0; i < n; i++) {
      if (random(0, 1) >= 0.5)
        knapsack[i] = a.knapsack[i];
      else
        knapsack[i] = b.knapsack[i];
    }
  }
  
  void mutate(float k) {
    for (int i = 0; i < n; i++) {
      if (random(0, 1) <= k) {
        knapsack[i] = !knapsack[i];
      }
    }
  }
  
  int compareTo(Subject b) {
  
    int pointsA = KP.getValue(knapsack);
    int pointsB = KP.getValue(b.knapsack);
    
    
    if (!KP.isValid(knapsack))
      pointsA -= 100 * (abs(KP.capacity - KP.getWeight(knapsack)));
    if (!KP.isValid(knapsack))
      pointsB -= 100 * (abs(KP.capacity - KP.getWeight(b.knapsack)));
      
    if (pointsA < pointsB)
      return -1;
    else if (pointsA > pointsB)
      return 1;
    else
      return 0;
  }
}

class KPInterface {
  int n;
  KnapsackProblem KP;
  float velocity;
  color colors[];
  
  float sizes[];
  
  KPInterface (KnapsackProblem KP, color colors[], float velocity) {
    this.KP = KP;
    this.n = KP.n;
    this.colors = colors;
    
    sizes = new float[n];
    this.velocity = velocity;
    for (int i = 0; i < n; i++) sizes[i] = 0;
  }
  
  void update(boolean knapsack[]) {
    
    for (int i = 0; i < n; i++) {
      if (knapsack[i]) {
        sizes[i] = min(1, sizes[i] + velocity / frameRate);
      } else {
        sizes[i] = max(0, sizes[i] - velocity / frameRate);
      }
    }
  }
  
  PGraphics display() {
    
    PGraphics aux = createGraphics(80, 400);
    aux.beginDraw();
    
    aux.stroke(255);
    aux.noFill();
    aux.rect(0, .1 * 400, 79, 400 - (.1 * 400) - 1);
    
    int totalHeight = int(int(400 - (.1 * 400) - 1) - int(.1 * 400));
    float pixelPerWeight = totalHeight / KP.capacity;
    
    float at = 400 - 1;
    for (int i = 0; i < n; i++) {
      aux.noStroke();
      aux.fill(colors[i]);
      aux.rect(1, at, 78, -(pixelPerWeight * KP.weight[i] * sizes[i]));
      at = at - (pixelPerWeight * KP.weight[i] * sizes[i]);
    }
    
    aux.endDraw();
    
    return aux;
  }
}

GA ga;
KPInterface kpi;
void setup() {
  size(1000, 1000);
  ga = new GA(10, .2, .15, new KnapsackProblem(20, 150));
  color colors[] = new color[ga.KP.n];
  for (int i = 0; i < ga.KP.n; i++) {
    colors[i] = color(random(0, 255), random(0, 255), random(0, 255));
  }
  
  kpi = new KPInterface(ga.KP, colors, 1);
  thread("RunGa");
}

void draw() {
  background(0);
  
  textSize(50);
  text(str(ga.generation), 100, 100);
  
  kpi.update(ga.Population.get(ga.n - 1).knapsack);
  image(kpi.display(), 250, 250);
  
  println(ga.Population.get(ga.n - 1).knapsack);
  println(ga.KP.getValue(ga.Population.get(ga.n - 1).knapsack));
}

void RunGa() {
  for (int i = 0; i < 10000000; i++)
    ga.RunGen();
}
