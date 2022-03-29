class Casa3D {

  int n;
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

int casas_qtd = 10;
ArrayList<Casa3D> casas;
float vel[];
void setup () {
  background(0);
  size(500, 500, P3D);
  casas = new ArrayList<Casa3D>();
  vel = new float[casas_qtd];

  for (int i = 0; i < casas_qtd; i++)
  {
    Casa3D casa = new Casa3D();
    casa.translate(random(0, width), random(0, height), random(0, -10000));
    vel[i] = random(-3, 3);
  }
}


void draw() {
  background(0);
  for (int i = 0; i < casas.size(); i++) {
    Casa3D casa = casas.get(i);
    
    casa.display();
    casa.rotateY(PI/180 * vel[i]);
    casa.rotateX(PI/180 * vel[i]);
    casa.rotateZ(PI/180 * vel[i]);
    //casa.rotateX(PI/180 / 10);
    //casa.rotateY(PI/180 / 10);
    //casa.rotateZ(PI / 180 / 10);
  }
}
