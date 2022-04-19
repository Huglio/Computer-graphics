PImage img;

class Matrix {
  int n, m;
  
  double matrix[][];
  
  Matrix(int n, int m) {
    this.n = n;
    this.m = m;
    
    matrix = new double[n][m];
  }
  
  Matrix(Matrix x) {
    n = x.n;
    m = x.m;
    
    matrix = new double[n][m];
  
    for (int i = 0; i < n; i++)
      for (int j = 0; j < m; j++)
        matrix[i][j] = x.matrix[i][j];
  }
  
  Matrix mult(Matrix b) {
    if (this.m != b.n)
      return new Matrix(0, 0);
    
    Matrix c = new Matrix(this.n, b.m);
    
    for (int i = 0; i < this.n; i++)
      for (int j = 0; j < b.m; j++)
      {
        c.matrix[i][j] = 0;
        for (int k = 0; k < this.m; k++)
          c.matrix[i][j] += this.matrix[i][k] * b.matrix[k][j];
      }
      
    return c;
  }
  
  Matrix transpose() {
    Matrix c = new Matrix(this.m, this.n);
    
    for (int i = 0; i < n; i++)
      for (int j = 0; j < m; j++)
        c.matrix[j][i] = matrix[i][j];
        
    return c;
  }
  
  void randomise() {
    for (int i = 0; i < n; i++)
      for (int j = 0; j < m; j++)
        matrix[i][j] = random(-5, 5);
  }
}

class AIController {
  
  ArrayList<Matrix> Layers;
  
  AIController (int input_size, int output_size) {
    Layers = new ArrayList<Matrix>();
    
    Layers.add(new Matrix(input_size, 4));
    Layers.add(new Matrix(4, 4));
    Layers.add(new Matrix(4, output_size));
    
    for (int i = 0; i < Layers.size(); i++)
      Layers.get(i).randomise();
  }
  
  
  Matrix pred(Matrix input) {
    Matrix resp = new Matrix(input);
    
    for (int i = 0; i < Layers.size(); i++)
      resp = resp.mult(Layers.get(i));
      
    return resp;
  }
};


class car {
  
  float throttle;
  float acceleration;
  float deccelerationPercentage;
  float velocity;
  float max_velocity;
  
  float steer;
  float steering;
  float steer_acceleration;
  float max_steering;
  PVector position;
  PVector forward;
  float size = 1;
  
  car (float x, float y) {
    position = new PVector(x, y);
    forward = new PVector(1, 0);
    
    throttle = 0;
    acceleration = 5;
    deccelerationPercentage = 0.98;
    velocity = 0;
    max_velocity = 5;
    
    steer = 0;
    steering = 0;
    steer_acceleration = 5;
    max_steering = 60;
  }
  
  void setSteer(float val) {
    val = max(-1, min(1, val));
    steer = val;
  }
  
  void setThrottle(float val) {
    throttle = val;
  }
  
  void update() {
    steering = max(-max_steering, min(max_steering, steering + steer * steer_acceleration));
    
    velocity = velocity * deccelerationPercentage;
    
    velocity = min(max_velocity, velocity + (throttle * acceleration) / frameRate);
    
    
    forward.rotate(radians(steering * velocity / frameRate));
    position.add(forward.x * velocity, forward.y * velocity);
  }
  
  void display() {
    imageMode(CENTER);
    println(forward.heading());
    pushMatrix();
    translate(position.x, position.y);
    rotate(forward.heading());
    image(img, 25, 0, 835 * 0.1 * size, 414 * 0.1 * size);
    fill(255, 0, 0);
    //circle(0, 0, 10);
    popMatrix();   
  }
}


car a;

void setup() {
  size(1000, 1000);
  img = loadImage("car.png");
  a = new car(250, 250);
}

void draw() {
  background(0);
  a.update();
  a.display();
}

void keyPressed() {
  if (key == 'w')
    a.setThrottle(1);
    
  if (key == 's')
    a.setThrottle(-1);
  
  if (key == 'd')
    a.setSteer(1);
    
  if (key == 'a')
    a.setSteer(-1);
}

void keyReleased() {
  if (key == 'w')
    a.setThrottle(0);
    
  if (key == 's')
    a.setThrottle(0);
    
  if (key == 'd')
    a.setSteer(0);
    
  if (key == 'a')
    a.setSteer(0);
}
