class Mola {
  Casa3D casa;
  float len = 100;
  float k = .01;
  
  Mola(Casa3D casa) {
    this.casa = casa; 
  }
  
  void update() {
    PVector myPos = new PVector(mouseX, mouseY);
    PVector pos = new PVector(casa.getMiddle().x, casa.getMiddle().y);
    
    float x = PVector.dist(myPos, pos);
    
    if (x > len) {
      PVector normal = PVector.sub(myPos, pos);
      casa.force.add(normal.mult((x - len) * k / frameRate));
    }
  }
}

class Casa3D {
  
  int n;
  PVector vel;
  PVector force;
  float points[] = {0, 100, 0,
    0, 0, 0,
    100, 0, 0,
    100, 100, 0,
    60, 100, 0,
    60, 50, 0,
    40, 50, 0,
    40, 100, 0,
    0, 100, 0,
    0, 100, -100,
    100, 100, -100,
    100, 100, 0,
    100, 0, 0,
    50, -50, 0,
    0, 0, 0,
    0, 0, -100,
    100, 0, -100,
    100, 0, 0,
    50, -50, 0,
    50, -50, -100,
    0, 0, -100,
    50, -50, -100,
    100, 0, -100,
    100, 100, -100,
    0, 100, -100,
    0, 0, -100};

  Casa3D () {
    n = points.length;
    vel = new PVector(0, 0);
    force = new PVector(0, 0);
  }


  void display() {
    noFill();
    stroke(255);
    strokeWeight(2);
    beginShape();
    for (int i = 0; i < n; i+=3)
      vertex(points[i], points[i + 1], points[i + 2]);
    endShape();
  }
  
  void update() {
    PVector pos = getMiddle();
    
    force.add(0, 10 / frameRate);
    vel.add(force);
    
    for (int i = 0; i < n; i+=3){
      points[i] += vel.x / (n / 3);
      points[i + 1] += vel.y / (n / 3);
    }
    
    rotateX(PI/180/frameRate * force.mag());
    rotateY(PI/180/frameRate * force.mag());
    rotateZ(PI/180/frameRate * force.mag());

    
    force = new PVector(0, 0);
  }

  PVector getMiddle() {
    PVector middle = new PVector(0, 0, 0);
    for (int i = 0; i < n; i+=3) {
      middle.x += points[i];
      middle.y += points[i + 1];
      middle.z += points[i + 2];
    }

    middle.x /= (n / 3);
    middle.y /= (n / 3);
    middle.z /= (n / 3);
    return middle;
  }

  void translate(float x, float y, float z) {
    for (int i = 0; i < n; i+=3) {
      points[i] += x;
      points[i + 1] += y;
      points[i + 2] += z;
    }
  }
  
  void scale(float x, float y, float z) {
    PVector middle = getMiddle();
    for (int i = 0; i < n; i+= 3)
    {
      points[i] -= middle.x;
      points[i + 1] -= middle.y;
      points[i + 2] -= middle.z;
      
      points[i] *= x;
      points[i + 1] *= y;
      points[i + 2] *= z;
      
      points[i] += middle.x;
      points[i + 1] += middle.y;
      points[i + 2] += middle.z;
    }
  }

  void rotateX(float angle) {

    PVector middle = getMiddle();
    for (int i = 0; i < n; i+=3) {
      float y = points[i + 1] - middle.y;
      float z = points[i + 2] - middle.z;

      float ny = y * cos(angle) - z * sin(angle);
      float nz = z * cos(angle) + y * sin(angle);

      points[i + 1] = ny + middle.y;
      points[i + 2] = nz + middle.z;
    }
  }

  void rotateY(float angle) {
    PVector middle = getMiddle();
    for (int i = 0; i < n; i+=3) {
      float x = points[i] - middle.x;
      float z = points[i + 2] - middle.z;

      float nx = x * cos(angle) - z * sin(angle);
      float nz = z * cos(angle) + x * sin(angle);

      points[i] = nx + middle.x;
      points[i + 2] = nz + middle.z;
    }
  }

  void rotateZ(float angle) {
    PVector middle = getMiddle();
    for (int i = 0; i < n; i+=3) {
      float x = points[i] - middle.x;
      float y = points[i + 1] - middle.y;

      float nx = x * cos(angle) - y * sin(angle);
      float ny = y * cos(angle) + x * sin(angle);

      points[i] = nx + middle.x;
      points[i + 1] = ny + middle.y;
    }
  }
}

int casas_qtd = 1;
Mola mola;
Casa3D casa;
void setup () {
  background(0);
  size(500, 500, P3D);
  casa = new Casa3D();
  mola = new Mola(casa);
  //casa.translate(random(0, width), random(0, height), 50);
  //casa.scale(.5, .5, .5);
}

void draw() {
  background(0);
  mola.update();
  casa.display();
  casa.update();
}
