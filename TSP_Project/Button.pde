class Button extends Object {
  boolean isClicked = false;
  boolean isHovered = false;
  
  Button(PVector pos) {
    super(pos);
    world.addButton(this);
  }
  
  void destroy() {
    super.destroy();
    
    world.removeButton(this);
  }
  
  void click() {
    isClicked = true;
  }
  void unclick() {
    isClicked = false;
  }
  
  void hover() {
    isHovered = true;
  }
  
  void unhover() {
    isHovered = false;
  }
  
  boolean isInside(PVector pos) {
    return false;
  }
}
