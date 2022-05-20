class Object {
  PVector pos;
  float scale;
  
  Object(PVector pos) {
    world.addObj(this);
    this.pos = pos;
    scale = 1;
  }
  
  void destroy() {
    world.removeObj(this);
  }
  
  void display() {
    
  }
  
  void update() {
    
  }
}
