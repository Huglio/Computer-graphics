class Mesh {
  PVector pos;
  float sizex;
  float sizey;
  int cx;
  int cy;
  
  float xoff = 0;
  float yoff = 0;
  float xspeed = .01;
  float yspeed = -.01;
  float noiseSize = .04;
  float noiseWeight = 600;
  
  Mesh(float x, float y, int cx, int cy) {
    sizex = x;
    sizey = y;
    this.cx = cx;
    this.cy = cy;
    xoff = 0;
    yoff = 0;
  }
  
  void display() {
    float quadxsize = sizex / cx;
    float quadysize = sizey / cy;
    
    for (int i = 0; i < cx; i++)
      for (int j = 0; j < cy; j++) {
        fill(255);
        beginShape(QUADS);
        vertex(i * quadxsize - sizex / 2, noiseWeight * noise(xoff + i * noiseSize, yoff + j * noiseSize), j * quadysize - sizey / 2);
        vertex(i * quadxsize - sizex / 2, noiseWeight * noise(xoff + i * noiseSize, yoff + (j + 1) * noiseSize), (j + 1) * quadysize - sizey / 2);
        vertex((i + 1) * quadxsize - sizex / 2, noiseWeight * noise(xoff + (i + 1) * noiseSize, yoff + (j + 1) * noiseSize), (j + 1) * quadysize - sizey / 2);
        vertex((i + 1) * quadxsize - sizex / 2, noiseWeight * noise(xoff + (i + 1) * noiseSize, yoff + j * noiseSize), j * quadysize - sizey / 2);
        endShape();
      }
  }
  
  void update() {
    xoff += xspeed;
    yoff += yspeed;
  }
}

Mesh mesh;
void setup() {
  size(500, 500, P3D);
  mesh = new Mesh(1000, 1000, 50, 50);
  camera(700, 800, 700, 0, 0, 0, 1, 1, 1);
}

void draw() {
  background(0);
  mesh.update();
  mesh.display();
}
