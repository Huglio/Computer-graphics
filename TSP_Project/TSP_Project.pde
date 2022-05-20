

Node x;
ClearButton clearbutton;
void setup() {
  size(500, 500);
  x = new Node(node_cnt++, new PVector(250, 250));
  clearbutton = new ClearButton(new PVector(10, 10));
}

void draw() {
  background(0);
  
  stroke(10);
  line(0, _control_reserved_space, width, _control_reserved_space);
  
  world.update();
  world.display();
  
  if (!isCheckingHovering)
    thread("checkHovering");
}






// Checks if mouse is hovering button
boolean isCheckingHovering = false;
void checkHovering() {
  isCheckingHovering = true;
  
  for (Button x : world.buttons) {
    if (x.isInside(new PVector(mouseX, mouseY)))
      x.hover();
    else if (x.isHovered)
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
