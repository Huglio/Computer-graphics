class Interactable extends Object {
      
    PVector mouseRelative;
    float maxScale = 1.1;
      
    boolean hovering = false;
    boolean selected = false;
      
    Interactable(PVector pos, float rot) {
        super(pos, rot);
      
        
        world.interactable.add(this);
    }
    
    void destroy() {
      super.destroy();
      
      world.interactable.remove(this);
    }
    
    void update() {
        super.update();
        
        scale = max(1, scale - .1);
    }
    
    void OnHover() {
      scale = min(maxScale, scale + 0.5 / frameRate);
      hovering = true;
    }
    
    void OnUnhover() {
      scale = max(1, scale - 0.5 / frameRate);
      hovering = false;
    }
    
    void OnSelect() {
      selected = true;
      mouseRelative = new PVector(pos.x - mouseX, pos.y - mouseY);
    }
    
    void OnUnselect() {
      selected = false;
    }
    
    boolean isHovering(){
      return false;
    }
}
