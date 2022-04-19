class diamond {
  PVector LastMouse;
  float d_height = 100;
  float d_width = 60;
  int n;
  float velocity_x = 0;
  float velocity_y = 0;
  
  float colors[] = {
    random(0, 255), random(0, 255), random(0, 255),
    random(0, 255), random(0, 255), random(0, 255),
    random(0, 255), random(0, 255), random(0, 255),
    random(0, 255), random(0, 255), random(0, 255),
    random(0, 255), random(0, 255), random(0, 255),
    random(0, 255), random(0, 255), random(0, 255),
    random(0, 255), random(0, 255), random(0, 255),
    random(0, 255), random(0, 255), random(0, 255),
    random(0, 255), random(0, 255), random(0, 255),
    random(0, 255), random(0, 255), random(0, 255),
    random(0, 255), random(0, 255), random(0, 255),
    random(0, 255), random(0, 255), random(0, 255),
  };
  
  float points[] = {
    0, d_height, 0,
    -d_width, 0, 0,
    -cos(radians(60)) * d_width, 0, sin(radians(60)) * d_width,
    0, d_height, 0,
    -cos(radians(60)) * d_width, 0, sin(radians(60)) * d_width,
    cos(radians(60)) * d_width, 0, sin(radians(60)) * d_width,
    0, d_height, 0,
    cos(radians(60)) * d_width, 0, sin(radians(60)) * d_width,
    d_width, 0, 0,
    0, d_height, 0,
    d_width, 0, 0,
    cos(radians(60)) * d_width, 0, -sin(radians(60)) * d_width,
    0, d_height, 0,
    cos(radians(60)) * d_width, 0, -sin(radians(60)) * d_width,
    -cos(radians(60)) * d_width, 0, -sin(radians(60)) * d_width,
    0, d_height, 0,
    -cos(radians(60)) * d_width, 0, -sin(radians(60)) * d_width,
    -d_width, 0, 0,
    
    0, -d_height/2, 0,
    -d_width, 0, 0,
    -cos(radians(60)) * d_width, 0, sin(radians(60)) * d_width,
    0, -d_height/2, 0,
    -cos(radians(60)) * d_width, 0, sin(radians(60)) * d_width,
    cos(radians(60)) * d_width, 0, sin(radians(60)) * d_width,
    0, -d_height/2, 0,
    cos(radians(60)) * d_width, 0, sin(radians(60)) * d_width,
    d_width, 0, 0,
    0, -d_height/2, 0,
    d_width, 0, 0,
    cos(radians(60)) * d_width, 0, -sin(radians(60)) * d_width,
    0, -d_height/2, 0,
    cos(radians(60)) * d_width, 0, -sin(radians(60)) * d_width,
    -cos(radians(60)) * d_width, 0, -sin(radians(60)) * d_width,
    0, -d_height/2, 0,
    -cos(radians(60)) * d_width, 0, -sin(radians(60)) * d_width,
    -d_width, 0, 0,
  };
  
  diamond () {
    n = points.length;
    LastMouse = new PVector(-1, -1);
    translate(250, 250, 0);
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
  
  void update() {
    if (LastMouse.x == -1 && LastMouse.y == -3) {
      LastMouse.x = mouseX;
      LastMouse.y = mouseY;
    }
    
    velocity_x *= .99;
    velocity_y *= .99;
    
    velocity_x += (mouseX - LastMouse.x) / frameRate;
    velocity_y += (mouseY - LastMouse.y) / frameRate;
    
    LastMouse.x = mouseX;
    LastMouse.y = mouseY;
    
    rotateX(PI/180 * -velocity_y);
    rotateY(PI/180 * -velocity_x);
  }
  
  void display() {
    fill(255);
    strokeWeight(2);
    stroke(0);
    beginShape(TRIANGLES);
    for (int i = 0; i < n; ) {
      fill(colors[i / 3], colors[i / 3 + 1], colors[i / 3 + 2]);
      for (int k = 0; k < 3; k++, i+=3)
        vertex(points[i], points[i + 1], points[i + 2]);
    }
    endShape();
  }
};


diamond a;
void setup() {
  a = new diamond();
  size(500, 500, P3D);
}

void draw() {
  background(0);
  a.display();
  a.update();
}

void keyPressed() {
  if (key == 's') {
    a.scale(1.1, 1.1, 1.1);
  } else if (key == 'd') {
    a.scale(.9, .9, .9);
  }
}
