class Node extends Button {
  
  int id;
  Node(int id, PVector pos) {
    super(pos);
    this.id = id;
    
    world.addNode(this);
  }
  
  void destroy() {
    super.destroy();
    
    world.removeNode(this);
  }
  
  
  void update() {
    if (isClicked)
      pos = new PVector(lerp(pos.x, mouseX, .5), lerp(pos.y, mouseY, .5));
    if (isHovered)
      scale = lerp(scale, _node_max_size / _node_size, .3);
    else if (scale > 1.01)
      scale = lerp(scale, 1, .3);
      
    pos.x = max(_node_max_size / 2, pos.x);
    pos.x = min(width - _node_max_size / 2, pos.x);
    pos.y = max(_control_reserved_space + _node_max_size / 2, pos.y);
    pos.y = min(height - _node_max_size / 2, pos.y);
  }
  
  boolean isHighlighted = false;
  void display() {
    strokeWeight(2);
    if (isHighlighted)
      stroke(_run_animation_color);
    else
      stroke(200);
    fill(0);
    circle(pos.x, pos.y, _node_size * scale);
    textSize(20 * scale);
    fill(200);
    textAlign(CENTER, CENTER);
    text(str(id), pos.x, pos.y - 3 * scale);
  }
  
  boolean isInside(PVector pos) {
    return PVector.dist(this.pos, pos) <= _node_size / 2 * scale;
  }
}
