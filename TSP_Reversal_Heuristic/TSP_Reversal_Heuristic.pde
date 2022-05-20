Graph graph;
TSP tsp;

int best[];

boolean first = true;
void setup() {
  graph = new Graph(50);
  tsp = new TSP(graph);
  tsp.step();
  fullScreen(1);
  size(700, 700);
  best = new int[0];
}


void draw() {
  background(0);
    
  tsp.update();
  tsp.display();
  
  if (tsp.solving == false && !tsp.done) {
    thread("solveTSP");
  } else if (tsp.done) {
    
    
    
  }
}

void solveTSP() {
  tsp.step();
}

void keyPressed() {
  thread("solveTSP");
}
