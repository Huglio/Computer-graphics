//println("test1");

class Graph {
  int n;
  Node nodes[];
  int edges[][];
  
  float _max_distance_percentage = .3;
  
  Graph(int n) {
    this.n = n;
    nodes = new Node[n];
    for (int i = 0; i < n; i++)
      nodes[i] = new Node(i, new PVector(random(0, width), random(0, height)));
    
    edges = new int[n][];
    for (int i = 0; i < n; i++)
      edges[i] = new int[n];
    
    for (int i = 0; i < n; i++) {
      edges[i][i] = 0;
      for (int j = i + 1; j < n; j++) {
        edges[i][j] = edges[j][i] = round(sqrt(pow(nodes[i].pos.x - nodes[j].pos.x, 2) + pow(nodes[i].pos.y - nodes[j].pos.y, 2)) / 10);
        edges[i][j] += random(-edges[i][j] * _max_distance_percentage, edges[i][j] * _max_distance_percentage);
      }
    }
  }
}

enum Anim {
  grow,
  shrink,
  none
}

class Node {
  int id;
  PVector pos;
  PVector scale;
  
  Anim playing;
  
  float _shrink_animation_speed = .1;
  float _shrink_animation_initial_size = 2;
  
  Node (int id, PVector pos) {
    this.id = id;
    this.pos = pos;
    this.scale = new PVector(1, 1);
    playShrink();
  }
  
  void display() {
    fill(0);
    strokeWeight(2);
    if (id == 0)
      stroke(60,60,255);
    else
      stroke(200);
    ellipse(pos.x, pos.y, 35 * scale.x, 35 * scale.y);
    fill(200);
    textSize(20 * scale.x);
    textAlign(CENTER, CENTER);
    text(str(id), pos.x, pos.y - (4 * scale.x));
  }
  
  void playShrink() {
    scale.x = _shrink_animation_initial_size;
    scale.y = _shrink_animation_initial_size;
  }
  
  void update() {
    scale.x = lerp(scale.x, (float)1, _shrink_animation_speed);
    scale.y = lerp(scale.y, (float)1, _shrink_animation_speed);
  }
}
