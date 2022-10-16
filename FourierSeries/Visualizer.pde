class Visualizer {
  Fourier f;
  PVector[] v;
  ArrayList<PVector> path;
  float pathThreashold = 25;
  float[] highlights;
  
  boolean Linesshow = true;
  
  float highhighlight = .8;
  float normalhighlight = .6;
  float lowhighlight = .3;
  float drawThreashold = 0;
  
  color clockcolor = color(255, 0, 0);
  color anticlockcolor = color(0, 255, 0);
  
  float time = 0;
  float time_speed = 0.0002;
  
  Visualizer(Fourier f, int n) {
    this.f = f;
    this.v = f.getVectors(n);
    path = new ArrayList<PVector>();
    path.add(new PVector(f.F(0).x, f.F(0).y, 0));
  }
  
  void display() {
    
    
    
    if (true) {
    float x = 0;
    float y = 0;
    for (int i = 0; i < v.length; i++) {
      PVector aux = new PVector(v[i].x, v[i].y);
      aux.rotate(TWO_PI * time * v[i].z);
      
      if (aux.mag() >= drawThreashold) {
        if (v[i].z < 0)
          stroke(anticlockcolor);
        else
          stroke(clockcolor);
        
        if (Linesshow) {
        strokeWeight(2);
        arrow(x, y, x + aux.x, y + aux.y);
        noFill();
        circle(x, y, sqrt(v[i].x * v[i].x + v[i].y * v[i].y) * 2);
        }
      }
      
      x += aux.x;
      y += aux.y;
    }
    
    
    if (time <= 1)
      path.add(new PVector(x, y));
    }
    
    for (int i = 0; i < path.size() - 1; i++) {
      PVector p1 = new PVector(path.get(i).x, path.get(i).y);
      PVector p2 = new PVector(path.get(i + 1).x, path.get(i + 1).y);
      
      //point(p1.x, p1.y);
      if (p1.dist(p2) <= pathThreashold) {
        stroke(200);
        strokeWeight(2);
        line(p1.x, p1.y, p2.x, p2.y);
      }
    }
  }
  
  void update() {
    time += time_speed;
  }
  
  void arrow(float sx, float sy, float ex, float ey) {
    PVector v = (new PVector(ex - sx, ey - sy));
    float angle = v.heading();
    float len = v.mag();
    
    float point_len = 3;
    
    pushMatrix();
    translate(sx, sy);
    rotate(angle);
    line(0,0,len, 0);
    line(len, 0, len - point_len, -point_len);
    line(len, 0, len - point_len, point_len);
    popMatrix();
  }
}
