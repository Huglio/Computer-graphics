class ClearButton extends Button {
  ClearButton(PVector pos) {
    super(pos);
    
    world.addButton(this);
  }
  
  void destroy() {
    super.destroy();
    
    world.removeButton(this);
  }
  
  void display() {
    
    if (isHovered) {
      stroke(200, 50, 50);
      fill(0);
      rect(pos.x, pos.y, _clear_button_x_size, _clear_button_y_size);
      textSize(20);
      fill(200, 100, 100);
      textAlign(CENTER, CENTER);
      text("Clear nodes", pos.x + (_clear_button_x_size / 2), pos.y + (_clear_button_y_size / 2) - 4);
    } else {
      stroke(200);
      fill(0);
      rect(pos.x, pos.y, _clear_button_x_size, _clear_button_y_size);
      textSize(20);
      fill(200);
      textAlign(CENTER, CENTER);
      text("Clear nodes", pos.x + (_clear_button_x_size / 2), pos.y + (_clear_button_y_size / 2) - 4);
    }
  }
  
  void click() {
    while(world.nodes.size() > 0)
      world.nodes.get(0).destroy();
      
    node_cnt = 0;
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
