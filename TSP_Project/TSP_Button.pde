class TSPButton extends Button{
  TSPButton(PVector pos) {
    super(pos);
  }
  
  void destroy() {
    super.destroy();
  }
  
   void display() {
    
    if (isHovered) {
      stroke(200, 50, 50);
      fill(0);
      rect(pos.x, pos.y, _clear_button_x_size, _clear_button_y_size);
      textSize(20);
      fill(200, 100, 100);
      textAlign(CENTER, CENTER);
      text("Run TSP", pos.x + (_clear_button_x_size / 2), pos.y + (_clear_button_y_size / 2) - 4);
    } else {
      stroke(200);
      fill(0);
      rect(pos.x, pos.y, _clear_button_x_size, _clear_button_y_size);
      textSize(20);
      fill(200);
      textAlign(CENTER, CENTER);
      text("Run TSP", pos.x + (_clear_button_x_size / 2), pos.y + (_clear_button_y_size / 2) - 4);
    }
  }
  
  void click() {
    tsp = new TSP();
  }
  
  void update() {
    
  }
  
    boolean isInside(PVector pos) {
      return (pos.x >= this.pos.x
      && pos.x <= this.pos.x+_clear_button_x_size
      && pos.y >= this.pos.y
      && pos.y <= this.pos.y+_clear_button_y_size);
    }
}
