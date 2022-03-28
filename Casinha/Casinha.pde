float scale = 100;

class Casa {
  float matrix[][] = {{-1, 0}, {-.2, 0}, {-.2, -.5}, {.2, -.5}, {.2, 0}, {1, 0}, {1, -1}, {0, -2}, {-1, -1}, {-1, 0}};

  void display() {
    stroke(255);
    noFill();
    beginShape();
    for (int i = 0; i < 10; i++) {
      vertex(matrix[i][0] + width/2, matrix[i][1] + height/2);
    }
    endShape();
  }

  void scale(float scale) {
    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 2; j++) {
        matrix[i][j] *= scale;
      }
    }
  }

  void translate(float x, float y) {
    for (int i = 0; i < 10; i++) {
      matrix[i][0] += x;
      matrix[i][1] += y;
    }
  }

  void rotate(float angle) {
    for (int i = 0; i < 10; i++) {
      float x = matrix[i][0];
      float y = matrix[i][1];

      float nx = x * cos(angle) - y * sin(angle);
      float ny = x * sin(angle) + y * cos(angle);

      matrix[i][0] = nx;
      matrix[i][1] = ny;
    }
  }
}

Casa a;
float step_length = 10;

void setup() {
  size(500, 500);
  a = new Casa();
  a.scale(40);
}

void draw() {
  background(0);
  a.display();
}

void keyPressed() {
  if ((keyPressed == true) && (key == CODED)) {
    if (keyCode == UP) {
      a.translate(0, -step_length);
      println("hsdfsldfh");
    } else if (keyCode == DOWN) {
      a.translate(0, step_length);
    } else if (keyCode == LEFT) {
      a.translate(-step_length, 0);
    } else if (keyCode == RIGHT) {
      a.translate(step_length, 0);
    }
  }

  if (key == 'w') {
    a.scale(1.2);
  } else if (key == 's') {
    a.scale(0.8);
  }

  if (key == 'e') {
    a.rotate(3 * PI/180);
  } else if (key == 'q') {
    a.rotate(-3 * PI/180);
  }
}
