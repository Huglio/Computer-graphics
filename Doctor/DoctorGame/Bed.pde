class Bed extends Interactable {
    PShape Bed;
    
    float x_speed;
    float y_speed;
    
    Bed(PVector pos, float rot) {
        super(pos, rot);
        Bed = loadShape("Bed.svg");
        
        x_speed = random(-3.5, 3.5);
        y_speed = random(-3, -5);
        this.rot = -10 * x_speed / 3.5;
        this.maxScale = 1.04;
    }
    
    void display() {
        Bed.disableStyle();
        fill(0);
        if (hovering)
          strokeWeight(2);
        else
          strokeWeight(1);
        stroke(255);
        
        pushMatrix();
        translate(pos.x, pos.y);
        pushMatrix();
        rotate(radians(rot));
        shape(Bed, 0, 0, Bed.width * scale, Bed.height * scale);
        popMatrix();
        popMatrix();
    }
    
    void update() {
        
        if (selected) {
          pos.x = mouseX + mouseRelative.x;
          pos.y = mouseY + mouseRelative.y;
          
          float x = mouseX - pmouseX;
          float y = mouseY - pmouseY;
          
          x_speed = x;
          y_speed = y;
        }
      
        pos.x += x_speed;
        pos.y += y_speed;
        
        
        if (pos.y > height) {
              y_speed *= -.4;
              pos.y = height;
          }
          if (pos.y - 180 < 0) {
              y_speed *= -.4;
              pos.y = 180;
          }
          if (pos.x - 150 < 0) {
              x_speed *= -.4;
              pos.x = 150;
          }
          if (pos.x + 150 > width) {
              x_speed *= -.4;
              pos.x = width - 150;
          }
        
        rot *= .9;
        
        x_speed *= .97;
        y_speed += 10 / frameRate;
    }
    
    boolean isHovering()  {
      if (mouseX >= (pos.x - 250) && mouseX <= (pos.x + 250) && mouseY >= (pos.y - 180) && mouseY <= pos.y) {
            return true;   
  
      }
      return false;
    }
}
