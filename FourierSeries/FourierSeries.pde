import geomerative.*;

RPoint[] points;
Fourier f;
Visualizer v;

ArrayList<PVector> paux;

void setup(){
    paux = new ArrayList<PVector>();
    
    size(800, 800);
    //fullScreen(1);
    
    Reader a = new Reader(this);
    points = a.getPoints();
    try {
        f = new Fourier(points);
        v = new Visualizer(f, 3000);
    } catch (Exception e) {
    }
    
    smooth();
}

void draw(){
    background(0);
    translate(width / 2, height / 2);
    
    v.display();
    v.update();
}

void keyPressed() {
  if (key == 'h') {
    v.Linesshow = !v.Linesshow;
  }
}
