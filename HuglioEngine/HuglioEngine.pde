// World object
/*
  Responsible for storing every HObject spawned (createObject)
  Should be the first Object created
  display funcition call display in every object spawned
  update function call update in every object spawned
*/

class HWorld {
  ArrayList<HObject> objects;
  
  HWorld() {
    objects = new ArrayList<HObject>();
  }
  
  <T> T createObject(T obj, PVector pos, float rot) {
    objects.add((HObject) obj);
    
    ((HObject)obj).setPosition(pos);
    ((HObject)obj).setRotation(rot);
    
    return obj;
  }
  
  void display() {
    for (HObject x : objects) {
      if (x.render)
        x.display();
    }
  }
  
  void update() {
    for (HObject x : objects) {
      x.update();
    }
  }
}

//HObject class
/*
    Base class, everything positioned in screen should inherit this
    Position and rotation become Relative if has Owner
*/

class HObject {
  PVector position;
  float rotation;
  HObject owner;
  
  boolean render;
  
  HObject () {
    position = new PVector(0, 0);
    rotation = 0;
    owner = null;
    render = true;
  }
  
  void setPosition(float x, float y) {
    position = new PVector(x, y);
  }
  
  void setPosition(PVector pos) {
    position = new PVector(pos.x, pos.y);
  }
  
  void setRotation(float angle) {
    rotation = radians(angle);
  }
  
  void setRotationRadians(float angleRad) {
    rotation = angleRad;
  }
  
  void setOwner(HObject owner) {
    this.owner = owner;
  }
  
  PVector getPosition() {
    return getPosition(true);
  }
  
  PVector getPosition(boolean isWorldPosition) {
    if (isWorldPosition && owner != null) {
      PVector ownerPos = owner.getPosition(true);
      PVector pos = position;
      pos.rotate(owner.getRotation(true));
      
      return new PVector(ownerPos.x + pos.x, ownerPos.y + pos.y);
    }
    
    return position;
  }
  
  float getRotation() {
    return getRotation(true);
  }
  
  float getRotation(boolean isWorldRotation) {
    if (isWorldRotation && owner != null)
      return owner.getRotation(true) + rotation;
      
    return rotation;
  }
  
  void display() {
    
  }
  
  void update() {
    
  }
}

class HShape extends HObject {
  HShape() {
    
  }
  
  void display() {
    super.display();
    
  }
  
  void update() {
    
  }
}

class HSphere extends HShape {
  float radius;
  
  HSphere (float r) {
    radius = r;
  }
  
  void setRadius(float r) {
    radius = r;
  }
  
  void display() {
    circle(getPosition().x, getPosition().y, radius);
  }
}

class HCustomShape extends HShape {
  ArrayList<PVector> points;
  
  HCustomShape() {
    points = new ArrayList<PVector>();
  }
  
  void addPoint(PVector pos) {
    points.add(new PVector(pos.x, pos.y));
    println(pos.x, pos.y);
  }
  
  void removePoint() {
    if (points.size() > 0)
      points.remove(0);
  }
  
  void display() {
    
    stroke(255);
    strokeWeight(2);
    noFill();
    beginShape();
    for (int i = 0; i < points.size() - 1; i++) {
      vertex(points.get(i).x, points.get(i).y);
      vertex(points.get(i + 1).x, points.get(i + 1).y);
    }
      
    if (points.size() >= 2) {
      vertex(points.get(points.size() - 1).x, points.get(points.size() - 1).y);
      vertex(points.get(0).x, points.get(0).y);
    }
    endShape();
  }
  
  void update() {
    
  }
}


class LaserBeam extends HObject {
  
  LaserBeam() {
    
  }
  
  void display() {
    
    
    float l = 0, r = 1000;
    
    while(r - l >= 1) {
      float mid = (r + l) / 2;
      
      println(mid);
      
      boolean collide = false;

      for (int i = 0; i < world.objects.size(); i++) {
        HCustomShape Shape = (HCustomShape)world.objects.get(i);
        
        
        for (int j = 0; j < Shape.points.size(); j++) {
          if (PVector.dist(position, Shape.points.get(j)) < mid)
            collide = true;
        }
      }
      
      if (collide)
          r = mid;
        else
          l = mid;
    }
      
      
      PVector dir = PVector.fromAngle(rotation);

      if (r == 1000) {
        fill(255, 0, 0);
        circle(position.x + (r * dir.x), position.y + (r * dir.y), 5);
        return;
      }
        
        line(position.x, position.y, position.x + (r * dir.x), position.y + (r * dir.y));
        
        println("here", r);
      
      circle(position.x, position.y, r / 2);
      
      LaserBeam beam = new LaserBeam();
      beam.position = new PVector(position.x + (r * dir.x), position.y + (r * dir.y));
      beam.rotation = rotation;
      beam.display();
    }
  
  
  void update() {
    
  }
}


HWorld world;
HShape shape;
HCustomShape Cshape;
LaserBeam laser;

void setup() {
  world = new HWorld();
  //shape = world.createObject(new HSphere(25), new PVector(0, 0), 0);
  Cshape = world.createObject(new HCustomShape(), new PVector(0, 0), 0);
  laser = new LaserBeam();
  
  background(0);
  size(500, 500);
}

void draw() {
    background(0);
    world.display();
    
    laser.setRotationRadians(PVector.sub(new PVector(mouseX, mouseY), laser.position).heading());
    laser.display();
    fill(255);
    circle(laser.position.x, laser.position.y, 25);
}

void mouseClicked() {
  if (mouseButton == LEFT) 
    Cshape.addPoint(new PVector(mouseX, mouseY));
  if (mouseButton == RIGHT)
    Cshape.removePoint();
}

void keyPressed() {
  if (key == 's')
    Cshape = world.createObject(new HCustomShape(), new PVector(0, 0), 0);
}
