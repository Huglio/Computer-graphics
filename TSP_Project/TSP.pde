class TSP {
  int n;
  
  int solution[];
  
  TSP() {
    n = world.nodes.size();
    solution = new int[n];
    
    for (int i = 0; i < n; i++)
      solution[i] = i;
    
    IntList aux = new IntList (solution);
    aux.shuffle();
    solution = aux.array();
  }
  
  boolean done = false;
  void step() {
    
    int best[] = new int[n];
    int bfit = fit(solution);
    
    for (int i = 0; i < n; i++) {
      for (int j = i + 1; j < n; j++) {
        int aux[] = new int[n];
        
        copyto(aux, solution);
        for (int k = 0; k < (j - i + 1) / 2; k++) {
          int tmp = aux[i + k];
          aux[i + k] = aux[j - k];
          aux[j - k] = tmp;
        }
        
        int cfit = fit(aux);
        
        if (cfit < bfit) {
          bfit = cfit;
          copyto(best, aux);
        }
      }
    }
    
    println(best);
    
    if (bfit != fit(solution)) {
      copyto(solution, best);
    } else {
      done = true;
    }
  }
  
  void display() {
    
    if (!done) {
      for (int i = 0; i < n; i++) {
        PVector pos1 = world.nodes.get(solution[i]).pos;
        PVector pos2 = world.nodes.get(solution[(i + 1) % n]).pos;
        
        stroke(200);
        line(pos1.x, pos1.y, pos2.x, pos2.y);
      }
    } else {
      
    }
  }
  
  int fit(int arr[]) {
    int sum = 0;
    for (int i = 1; i < arr.length; i++)
      sum += PVector.dist(world.nodes.get(arr[i - 1]).pos, world.nodes.get(arr[i]).pos);
    sum += PVector.dist(world.nodes.get(arr[n - 1]).pos, world.nodes.get(arr[0]).pos);
    return sum;
  }
  
  void copyto(int to[], int from[]) {
    for (int i = 0; i < to.length; i++)
      to[i] = from[i];
  }
}
