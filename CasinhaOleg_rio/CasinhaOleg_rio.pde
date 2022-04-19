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
    rotateX(PI/180);
    rotateY(PI/180);
    rotateZ(PI/180);
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

Casa3D casa;
void setup () {
  background(0);
  size(500, 500, P3D);
  casa = new Casa3D();
  casa.translate(width / 2 - 50, height / 2 + 20, 0);
}

void draw() {
  background(0);
  casa.update();
  casa.display();
}
