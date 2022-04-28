import java.util.*;   

float best_x = 0, best_y = 0;
Vaga vaga;

PImage carimg;
PImage vagaimg;

class Vaga {
  PVector pos;
  PVector dir;
  
  float Points[] = {
    -50, 30,
    -50, 0,
    -50, -30,
    50, 30,
    50, 0,
    50, -30,
    50, 60,
    -50, 60,
    0, 60
  };
  
  int n;
  
  Vaga(float x, float y, float angle) {
    n = Points.length;
    pos = new PVector(getMiddle().x, getMiddle().y);
    dir = PVector.fromAngle(radians(angle));
        
    rotateVaga(dir.heading());
    translateVaga(x, y);
  }
  
  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(dir.heading());
    image(vagaimg, 0, 0, 320, 240);
    popMatrix();
    
    //for (int i = 0; i < n; i+=2) {
      //fill(255, 0, 0, 100);
      //circle(Points[i], Points[i + 1], 25);
    //}
    
    //circle(getMiddle().x, getMiddle().y, 20);
  }
  
  void translateVaga(float x, float y) {
    
    pos.x += x;
    pos.y += y;
    
    for (int i = 0; i < n; i+=2) {
      Points[i] += x;
      Points[i + 1] += y;
    }
  }
  
  void rotateVaga(float angle) {
    PVector middle = getMiddle();
    println(middle.x);
    
    for (int i = 0; i < n; i+=2) {
      float a = Points[i] - middle.x;
      float b = Points[i + 1] - middle.y;
      
      float anew = a * cos(angle) - b * sin(angle);
      float bnew = b * cos(angle) + a * sin(angle);
      
      Points[i] = anew + middle.x;
      Points[i + 1] = bnew + middle.y;
    }
  }
  
  PVector getMiddle() {
    float x = 0;
    float y = 0;
    
    for (int i = 0; i < n; i+=2) {
      x += Points[i];
      y += Points[i + 1];
    }
    
    x /= (n / 2);
    y /= (n / 2);
    
    return new PVector(x, y);
  }
  
  boolean checkCollision(Car car) {
    
    for (int i = 0; i < n; i+=2) {
      float x = Points[i];
      float y = Points[i + 1];
      
      if (PVector.sub(car.Col1, new PVector(x, y)).mag() < 30 || PVector.sub(car.Col2, new PVector(x, y)).mag() < 30)
        return true;
      
    }
    
    return false;
  }
}

class Matrix {
  int n, m;
  
  float matrix[][];
  
  Matrix(int n, int m) {
    this.n = n;
    this.m = m;
    
    matrix = new float[n][m];
  }
  
  Matrix(Matrix x) {
    n = x.n;
    m = x.m;
    
    matrix = new float[n][m];
  
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
        matrix[i][j] = random(-1, 1);
  }
  
  float sigmoid(float x) {
    return 1 / (1 + exp(-x));
  }
  
  void sigmoidAll() {
    for (int i = 0; i < n; i++)
      for (int j = 0; j < m; j++)
        matrix[i][j] = sigmoid(matrix[i][j]);
  }
}

class GA {
  
  int ind_cnt;
  int gen_cnt;
  int moves;
  ArrayList<AIController> Population;
  
  GA(int cnt) {
    
    ind_cnt = cnt;
    gen_cnt = 0;
    Population = new ArrayList<AIController>();
    
    for (int i = 0; i < cnt; i++) {
      Population.add(new AIController());
      Population.get(i).possess(new Car(250, 250));
    }
    
    moves = 300;
  }
  
  
  
  void runGeneration () {
    
    
    if (moves >= 0) {
      update();
      display();
      moves--;
    } else {  
      
      gen_cnt++;
      
      Collections.sort(Population);

      
      best_x = Population.get(Population.size() - 1).car.position.x;
      best_y = Population.get(Population.size() - 1).car.position.y;
      
      
      ArrayList<AIController> NewPopulation = new ArrayList<AIController>();
      
      for (int i = 0; i < Population.size() - (ind_cnt * .15); i++)
        NewPopulation.add(crossOver(Population.get(int(random(0, Population.size()))), Population.get(int(random(0, Population.size())))));
      
      for (int i = max(0, ceil(Population.size() - (ind_cnt * .15))); i < Population.size(); i++)
        NewPopulation.add(Population.get(i));
      
      Population = NewPopulation;
      
      for (int i = 0; i < Population.size(); i++)
        Population.get(i).possess(new Car(250, 250));
            
      moves = 300;
    }
  }
  
  AIController crossOver(AIController a, AIController b) {
    AIController c = new AIController();
    
    for (int i = 0; i < c.Layers.size(); i++)
      for (int x = 0; x < c.Layers.get(i).n; x++)
        for (int y = 0; y < c.Layers.get(i).m; y++)
          if (random(0, 1) >= 0.5)
            c.Layers.get(i).matrix[x][y] = mutateChance(a.Layers.get(i).matrix[x][y]);
          else
            c.Layers.get(i).matrix[x][y] = mutateChance(b.Layers.get(i).matrix[x][y]);
            
    return c;
  }
  
  float mutateChance(float val) {
    if (random(0, 1) <= 0.1)
      return val *= random(-1, 1);
    return val;
  }
  
  void update() {
    for (int i = 0; i < Population.size(); i++) {
      Population.get(i).update();
      Population.get(i).car.update();
    }
  }
  
  void display() {
    for (int i = max(0, round(Population.size() * (1 - 0.05))); i < Population.size(); i++) {
      Population.get(i).car.display();
    }
    
    fill(255, 255, 255);
    textSize(50);
    text(gen_cnt, 25, 80);
  }
}

class AIController implements Comparable<AIController> {
  
  ArrayList<Matrix> Layers;
  Car car;
  
  AIController () {
    Layers = new ArrayList<Matrix>();
    
    Layers.add(new Matrix(17, 8));
    Layers.add(new Matrix(8, 6));
    Layers.add(new Matrix(6, 4));
    
    for (int i = 0; i < Layers.size(); i++)
      Layers.get(i).randomise();
  }
  
  void possess(Car a) {
    this.car = a;
  }
  
  void update() {
    if (car == null)
      return;
    
    if (vaga.checkCollision(car)) {
      killMovement();
      return;  
    }
    
    Matrix p = pred(getInput());
    
    //0 0 frente
    //0 1 tras
    //0 2 direita
    //0 3 esquerda
        
    if (p.matrix[0][0] >= 0.5 && p.matrix[0][1] >= 0.5)
      car.setThrottle(0);
    else if (p.matrix[0][0] >= 0.5)
      car.setThrottle(1);
    else if (p.matrix[0][1] >= 0.5)
      car.setThrottle(-1);
      
    if (p.matrix[0][2] >= 0.5 && p.matrix[0][3] >= 0.5)
      car.setSteer(1);
    else if (p.matrix[0][2] >= 0.5)
      car.setSteer(1);
    else if (p.matrix[0][3] >= 0.5)
      car.setSteer(-1);
  }
  
  Matrix pred(Matrix input) {
        
    Matrix resp = new Matrix(input);
        
    for (int i = 0; i < Layers.size(); i++) {
      resp = resp.mult(Layers.get(i));
      
    }
  
    resp.sigmoidAll();

    return resp;
  }
  
  void killMovement() {
    if (car == null)
      return;
    
    car.velocity = 0;
    car.setThrottle(0);
    car.setSteer(0);
  }
  
   Matrix getInput() {
     if (car == null)
       return new Matrix(0, 0);
    
    Matrix Input = new Matrix(1, 17);
    
    Input.matrix[0][0] = car.velocity / car.max_velocity;
    Input.matrix[0][1] = car.steering / car.max_steering;
    Input.matrix[0][2] = car.forward.heading() / (TWO_PI);
    Input.matrix[0][3] = PVector.angleBetween(vaga.dir, car.forward) / (TWO_PI);
    Input.matrix[0][4] = PVector.sub(car.position, vaga.pos).x / width;
    Input.matrix[0][5] = PVector.sub(car.position, vaga.pos).y / height;
    Input.matrix[0][6] = PVector.sub(car.position, vaga.pos).mag() / (sqrt(width * width + height * height));
    Input.matrix[0][7] = PVector.sub(vaga.pos, car.position).heading() / (TWO_PI);
    
    for (int i = 0; i < 9; i++) {
      Input.matrix[0][8 + i] = PVector.sub(car.position, new PVector(vaga.Points[(i * 2)], vaga.Points[(i * 2) + 1])).mag();
      Input.matrix[0][8 + i] /= (sqrt(width * width + height * height));
    }
    
    return Input;
  }
  
  int compareTo(AIController b) {
    if (car == null)
      return 0;
      
    float aPoints = 0;
    for (int i = 0; i < vaga.n; i += 2) {
      float x = PVector.sub(car.position, new PVector(vaga.Points[i], vaga.Points[i + 1])).mag();
      aPoints += x * x;
    }
     
    if (vaga.checkCollision(car)) {
      aPoints -= 500;
    }
      
    float bPoints = 0;
    for (int i = 0; i < vaga.n; i += 2) {
      float x = PVector.sub(b.car.position, new PVector(vaga.Points[i], vaga.Points[i + 1])).mag();
      bPoints += x * x;
    }
    
    if (vaga.checkCollision(b.car)) {
      bPoints -= 500;
    }
          
    if (aPoints < bPoints)
      return 1;
      
    if (aPoints == bPoints)
      return 0;
      
    return -1;
  }
};


class Car {
  
  PVector Col1;
  PVector Col2;
  
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
  
  Car (float x, float y) {
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
    
    Col1 = new PVector(x - 5, y);
    Col2 = new PVector(x + 50, y);
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
    Col1.add(forward.x * velocity, forward.y * velocity);
    Col2.x = Col1.x + 50 * forward.x;
    Col2.y = Col1.y + 50 * forward.y;
  }
  
  void display() {
    imageMode(CENTER);
    pushMatrix();
    translate(position.x, position.y);
    rotate(forward.heading());
    image(carimg, 25, 0, 835 * 0.1 * size, 414 * 0.1 * size);
    fill(255, 0, 0);
    //circle(0, 0, 10);
    popMatrix();   
    
    //circle(Col1.x, Col1.y, 25);
    //circle(Col2.x, Col2.y, 25);
  }
  
 
}


Car a;
GA ga;

void setup() {
  size(1000, 1000);
  carimg = loadImage("car.png");
  vagaimg = loadImage("VagaImg.png");
  vaga = new Vaga(800, 500, 60);
  a = new Car(250, 250);
  ga = new GA(1000);
  
}

void draw() {
  background(0);
  a.update();
  a.display();
  vaga.display();
  
  ga.runGeneration();
  
  fill(255, 0, 0);
  circle(best_x, best_y, 25);
  circle(0, 0, 25);
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
