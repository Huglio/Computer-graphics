float gravity = 10;

class Ball {
  PVector pos;
  PVector vel;
  PVector force;
  float airResist;
  float size;
  
  Ball() {
    pos = new PVector(0, 0);
    vel = new PVector(0, 0);
    force = new PVector(0, 0);
    airResist = .06;
    size = 50;
  }
  
  void update() {
    force.add(0, gravity / frameRate);
    
    PVector airForce = new PVector();
    vel.normalize(airForce);
    
    airForce.mult(-airResist * vel.mag() * vel.mag() / frameRate);
    
    force.add(airForce);
    
    vel.add(force);
    pos.add(vel);
    
    force = new PVector(0, 0);
  }
  
  void display() {
    fill(0);
    stroke(255);
    strokeWeight(2);
    circle(pos.x, pos.y, size);
  }
}

class MouseBall extends Ball {
  MouseBall() {
    super();
    this.size = 25;
  }
  
  void update() {
    pos.x = mouseX;
    pos.y = mouseY;
  }
}

class Spring {
  Ball a;
  Ball b;
  float len;
  float k;
  
  Spring (Ball a, Ball b, float len, float k) {
    this.a = a;
    this.b = b;
    this.len = len;
    this.k = k;
  }
  
  void update() {
    float x = PVector.dist(a.pos, b.pos);
    
    if (x > len) {
      PVector aForce = PVector.sub(b.pos, a.pos).normalize().mult((x - len) * k / frameRate);
      PVector bForce = PVector.mult(aForce, -1);
      
      a.force.add(aForce);
      b.force.add(bForce);
    }
  }
  
  void display() {
    stroke(255);
    strokeWeight(2);
    line(a.pos.x, a.pos.y, b.pos.x, b.pos.y);
  }
}

Ball a;
Ball b;
Spring x;
void setup () {
  background(0);
  fullScreen(0);
  size(500, 500);
  a = new MouseBall();
  b = new Ball();
  x = new Spring(a, b, 100, 1);
}

void draw() {
  background(0);

  a.update();
  b.update();
  x.update();
  
  x.display();
  a.display();
  b.display();
}
