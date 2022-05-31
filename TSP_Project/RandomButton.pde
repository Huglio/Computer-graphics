class RandomButton extends Button {
  RandomButton(PVector pos) {
    super(pos);
  }
  
  void display() {
    
    if (isHovered) {
      stroke(200, 50, 50);
      fill(0);
      rect(pos.x, pos.y, _clear_button_x_size, _clear_button_y_size);
      textSize(20);
      fill(200, 100, 100);
      textAlign(CENTER, CENTER);
      text("Spawn nodes", pos.x + (_clear_button_x_size / 2), pos.y + (_clear_button_y_size / 2) - 4);
    } else {
      stroke(200);
      fill(0);
      rect(pos.x, pos.y, _clear_button_x_size, _clear_button_y_size);
      textSize(20);
      fill(200);
      textAlign(CENTER, CENTER);
      text("Spawn nodes", pos.x + (_clear_button_x_size / 2), pos.y + (_clear_button_y_size / 2) - 4);
    }
  }
  
  void click() {
    for (int i = 0; i < 10; i++) {
      
      float x = random(_node_max_size / 2, width - _node_max_size / 2);
      float y = random(_control_reserved_space + _node_max_size / 2, height - _node_max_size / 2);
      
      
      new Node(node_cnt++, new PVector(x, y));
    }
  }
  
  boolean isInside(PVector pos) {
      return (pos.x >= this.pos.x
      && pos.x <= this.pos.x+_clear_button_x_size
      && pos.y >= this.pos.y
      && pos.y <= this.pos.y+_clear_button_y_size);
    }
}
