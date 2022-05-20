//println("test2");

class TSP {
  Graph graph;
  int n;
  int solution[];
  
  boolean solving = false;
  boolean done = false;
    
  TSP(Graph graph) {
    this.graph = graph;
    this.n = graph.n;
    solution = new int[n];
    
    for (int i = 0; i < n; i++)
      solution[i] = i;
    
    IntList Aux = new IntList(solution);
    Aux.shuffle();
    
    solution = Aux.array();
  }
  
  int fit(int a[]) {
    int res = 0;
    for (int i = 1; i < n; i++)
      res += graph.edges[a[i - 1]][a[i]];
    
    res += graph.edges[a[n - 1]][a[0]];
    
    return res;
  }
  
  void display() {
    
    for (int i = 1; i < n; i++) {
      PVector pos1 = graph.nodes[solution[i - 1]].pos;
      PVector pos2 = graph.nodes[solution[i]].pos;
      
      stroke(200);
      line(pos1.x, pos1.y, pos2.x, pos2.y);
    }
    
    PVector pos1 = graph.nodes[solution[n - 1]].pos;
    PVector pos2 = graph.nodes[solution[0]].pos;
    
    stroke(200);
    line(pos1.x, pos1.y, pos2.x, pos2.y);
    
    for (int i = 0; i < n; i++) {
      graph.nodes[i].display();
    }
  }
  
  void step() {
    solving = true;
    int best[] = new int[n];
    int bfit = fit(solution);
        
    for (int i = 0; i < n; i++) {
      for (int j = i + 1; j < n; j++) {
        int aux[] = new int[n];
        copyArray(aux, solution);
        
        for (int k = 0; k < (j - i + 1) / 2; k++) {
          int temp = aux[i + k];
          
          aux[i + k] = aux[j - k];
          aux[j - k] = temp;
        }
        
        
        if (fit(aux) < bfit) {
          bfit = fit(aux);
          copyArray(best, aux);
        }
      }
    }
        
    if (bfit < fit(solution)) {
      
      for (int i = 0; i < n; i++) {
        if (solution[i] != best[i])
          graph.nodes[i].playShrink();
      }
      copyArray(solution, best);
    } else {
      done = true;
    }
    
    solving = false;
  }
  
  void update() {
    for (int i = 0; i < n; i++) {
      graph.nodes[i].update();
    }
  }
  
  void copyArray(int to[], int from[]) {
    for (int i = 0; i < from.length; i++)
      to[i] = from[i];
  }
}
