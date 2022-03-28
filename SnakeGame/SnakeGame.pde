class Body {
  Body child;
  PVector pos;
  float len;
  
  Body (PVector pos, float len) {
    this.child = null;
    this.len = len;
    this.pos = pos;
  }

  void update() {
    if (child != null) {
      if (PVector.dist(child.pos, pos) > len) {
        child.pos = PVector.add(PVector.mult(PVector.sub(child.pos, pos).normalize(), len), pos);
      }

      child.update();
    }
  }
  
  void display() {
    fill(0, 200, 0);
    noStroke();
    circle(pos.x, pos.y, 25);
    
    if (child != null) {
      child.display();
    }
  }
}

class Head extends Body {
  Head(PVector pos, float len) {
    super(pos, len);
  }
  
  void update() {
    pos.x = lerp(pos.x, mouseX, 0.05);
    pos.y = lerp(pos.y, mouseY, 0.05);
    
    super.update();
  }
}



class Snake {
  Body head;
  Body tail;
  float len;
  int cnt = 0;
  
  Snake(float len) {
    this.len = len;
    head = tail = new Head(new PVector(0, 0), len);
  }
  
  void update() {
    head.update();
  }
  
  void display() {
    head.display();
  }
  
  void addBody() {
    tail.child = new Body(tail.pos.copy(), len);
    tail = tail.child;
    cnt++;
  }
  
  void removeBody() {
    if (head == tail) return;
    
    Body aux = head;
    while (aux.child != tail)
      aux = aux.child;
      
    aux.child = null;
    tail = aux;
    cnt--;
  }
}

class Apple {
  Snake snake;
  PVector pos;
  
  Apple(Snake snake) {
    this.snake = snake;
    pos = new PVector(0, 0);
  }
  
  void display() {
    fill(255);
    circle(pos.x, pos.y, 20);
  }
  
  void update() {
    if (PVector.dist(snake.head.pos, pos) < snake.head.len) {
      for (int i = 0; i < 1; i++)
        snake.addBody();
        
       spawn();
    }
  }
  
  void spawn() {
    pos.x = random(0, width - 50);
    pos.y = random(0, height - 50);
  }
}

class Shot {
  Snake snake;
  PVector pos;
  PVector vel;
  float len;
  float velocity;
  
  Shot (Snake snake, float len, float velocity) {
    this.velocity = velocity;
    this.snake = snake;
    this.len = len;
    pos = new PVector(random(0, width), random(0, height));
    vel = PVector.mult(PVector.random2D(), velocity);
  }
  
  void update () {
    pos.add(vel);
    
    if (pos.x > width) {
      pos.x = width;
      vel.x *= -1;
    }
    if (pos.x < 0) {
      pos.x = 0;
      vel.x *= -1;
    }
    if (pos.y > height) {
      pos.y = height;
      vel.y *= -1;
    }
    if (pos.y < 0) {
      pos.y = 0;
      vel.y *= -1;
    }
    
    Body aux = snake.head;
    
    while(aux != null) {
      if (PVector.dist(aux.pos, pos) < (aux.len + len) / 2) {
        
        PVector normal = PVector.sub(pos, aux.pos).normalize();
        PVector nVel = PVector.sub(vel, PVector.mult(normal, 2 * PVector.dot(normal, vel)));
        
        vel = nVel;
        pos = PVector.add(aux.pos, PVector.mult(normal, aux.len + len));
        
        snake.removeBody();
        
        return;
      }
      aux = aux.child;
    }
  }
  
  void display() {
    fill(255, 0, 0);
    circle(pos.x, pos.y, len);
  }
}

Snake snake;
Apple apple;
ArrayList<Shot> shotlist;
int shotcnt=  5;
void setup () {
  fullScreen(0);
  size(500, 500);
  shotlist = new ArrayList<Shot>();
  snake = new Snake(15);
  apple = new Apple(snake);
  
  for (int i = 0; i < shotcnt; i++) {
    shotlist.add(new Shot(snake, random(15, 25), 5));
  }
    
  apple.spawn();
}

void draw() {
 background(0);

 snake.update();
 snake.display();
 
 apple.update();
 apple.display();
 
 for (int i = 0; i < shotcnt; i++) {
   shotlist.get(i).update();
   shotlist.get(i).display();
 }
 
 textSize(128);
 fill(255);
 text(snake.cnt + 1, 40, 120);
}
