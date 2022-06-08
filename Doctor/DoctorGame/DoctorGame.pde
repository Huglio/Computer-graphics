
World world;
Monitor monitor;
Bed bed;
Seringe seringe;
Person person;


void setup() {
    frameRate(60);
    size(1000, 500);
    world = new World();
    
    monitor = new Monitor(new PVector(width / 2, height), 0);
    bed = new Bed(new PVector(width / 4, height), 0);
    seringe = new Seringe(new PVector(width * 2 / 3, height / 2), 0);
    person = new Person(new PVector(0, 0), 0, bed);
}

void draw() {
    background(0);

    if (!isCheckingHovering)
      thread("checkHover");

    
    world.display();
    world.update();
    
    fill(255);
    circle(0, 0, 25);

}

boolean isCheckingHovering = false;
void checkHover() {
  isCheckingHovering = true;
  
  boolean canHover = true;
  for (Interactable x : world.interactable) {
    if (canHover && x.isHovering()) {
      x.OnHover();
      canHover = false;
    } else {
      x.OnUnhover();
  }
  
  isCheckingHovering = false;
  }
}

Interactable selected;
void mousePressed() {
  if (mouseButton == LEFT) {
    for (Interactable x : world.interactable) {
      if (x.isHovering()) {
        if (selected != null)
          selected.OnUnselect();
        
        x.OnSelect();
        selected = x;
        break;
      }
    }
  }
}

void mouseReleased() {
  if (mouseButton == LEFT && selected != null) {
    selected.OnUnselect();
  }
}
