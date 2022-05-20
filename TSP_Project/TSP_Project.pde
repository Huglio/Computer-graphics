

ClearButton clearbutton;
TSPButton tspbutton;
TSP tsp;
void setup() {
  size(500, 500);
  clearbutton = new ClearButton(new PVector(10, 10));
  tspbutton = new TSPButton(new PVector(_clear_button_x_size + 20, 10));
}

void draw() {
  background(0);
  
  stroke(10);
  line(0, _control_reserved_space, width, _control_reserved_space);
  
  if (tsp != null) {
    tsp.step();
    tsp.display();
  }
  
  world.update();
  world.display();
  
  if (!isCheckingHovering)
    thread("checkHovering");
}


// Checks if mouse is hovering button
boolean isCheckingHovering = false;
void checkHovering() {
  isCheckingHovering = true;
  
  for (int i = 0; i < world.buttons.size(); i++) {
    Button x = world.buttons.get(i);
    if (x != null && x.isInside(new PVector(mouseX, mouseY)))
      x.hover();
    else
      x.unhover();
  }
  
  isCheckingHovering = false;
}

void mousePressed() {
  for (Button x : world.buttons) {
    if (x.isInside(new PVector(mouseX, mouseY))) {
      x.click();
      return;
    }
  }
  
  //Nothing clicked, create Node
  new Node(node_cnt++, new PVector(mouseX, mouseY));
}

void mouseReleased() {
  for (Button x : world.buttons) {
    if (x.isClicked) {
      x.unclick();
      return;
    }
  }
}


void keyPressed() {
  if (tsp != null)
    tsp.step();
}
