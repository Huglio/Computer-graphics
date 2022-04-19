PImage img;

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
    circle(0, 0, 10);
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
