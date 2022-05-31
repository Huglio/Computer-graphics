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
    if (solution == null || solution.length <= 1)
      return;
    
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
          
          done = false;
          walk = 0;
          at = 0;
          
          
        }
      }
    }
    
    if (bfit != fit(solution)) {
      copyto(solution, best);
      for (int i = 0; i < n; i++)
            world.nodes.get(i).isHighlighted = false;
    } else {
      done = true;
      
      int zero_at = 0;
      while(solution[zero_at] != 0)
        zero_at++;
      
      if (zero_at != 0) {
      int aux[] = new int[n];
      copyto(aux, solution);
      
      for (int i = 0; i < n; i++)
        solution[i] = aux[(zero_at + i) % n];
      }
    }
  }
  
  float walk = 0;
  int at = 0;
  void display() {
    
    if (!done) {
      for (int i = 0; i < n; i++) {
        PVector pos1 = world.nodes.get(solution[i]).pos;
        PVector pos2 = world.nodes.get(solution[(i + 1) % n]).pos;
        
        stroke(200);
        line(pos1.x, pos1.y, pos2.x, pos2.y);
      }
    } else {
      float x = fit(solution) * walk;
      
      for(int i = 0; i < n; i++) {
        PVector pos1 = world.nodes.get(solution[i]).pos;
        PVector pos2 = world.nodes.get(solution[(i + 1) % n]).pos;
        
        PVector mid = PVector.lerp(pos1, pos2, max(0, min(1, x / PVector.dist(pos1, pos2))));
        
        if (max(0, min(1, x / PVector.dist(pos1, pos2))) != 0 && at <= i) {
          world.nodes.get(solution[at]).scale = _node_max_size / _node_size * 1.5;
          world.nodes.get(solution[at]).isHighlighted = true;
          at++;
        }
        
        strokeWeight(_run_animation_weight);
        stroke(_run_animation_color);
        line(pos1.x, pos1.y, mid.x, mid.y);
        
        strokeWeight(2);
        stroke(200);
        line(mid.x, mid.y, pos2.x, pos2.y);
        
        x -= PVector.dist(pos1, pos2);
      }
      
    walk = min(1.1, walk + 1 / _time_to_run_tsp_animation / frameRate);
  }
  
}
  
  int fit(int arr[]) {
    int sum = 0;
    for (int i = 1; i < arr.length; i++)
      sum += PVector.dist(world.nodes.get(arr[i - 1]).pos, world.nodes.get(arr[i]).pos);
    
    if (world.nodes.size() > 1)
      sum += PVector.dist(world.nodes.get(arr[n - 1]).pos, world.nodes.get(arr[0]).pos);
    return sum;
  }
  
  void copyto(int to[], int from[]) {
    for (int i = 0; i < to.length; i++)
      to[i] = from[i];
  }
}
