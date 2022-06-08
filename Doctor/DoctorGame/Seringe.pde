class Seringe extends Interactable{   
    PShape Seringe;

    boolean asleep = true;
    PVector velocity;
    
    float drot;
    float drotv;

     Seringe(PVector pos, float rot) {
        super(pos, rot);
        Seringe = loadShape("Seringe.svg");
        this.drot = this.rot;
        this.drotv = 9;
        scale = 1;
        
        velocity = new PVector(0, 0);
    }
    
    void display() {
        
        super.display();
        
        Seringe.disableStyle();
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
        
        shape(Seringe, 0, 0, Seringe.width * scale, Seringe.height * scale);
        strokeWeight(1);
        
        popMatrix();
        popMatrix();
    }
    
    float min = 209432;
    float max = -23049324;
    void update() {
        
        if (selected) {
          
          pos.x = mouseX + mouseRelative.x;
          pos.y = mouseY + mouseRelative.y;
          
          asleep = false;
          velocity.x = mouseX - pmouseX;
          velocity.y = mouseY - pmouseY;
          
          if (velocity.mag() > 0.01) {
              PVector normalized = new PVector(velocity.x, velocity.y);
              normalized.normalize();
          
              this.drot = (-90 + degrees(normalized.heading()) + 360) % 360;
          }
          
        } else if (!asleep) {
            velocity.y += (10) / frameRate;
            
            pos.x += velocity.x;
            pos.y += velocity.y;
            
            velocity.limit(18);
            
            if (velocity.mag() > 0.01) {
              PVector normalized = new PVector(velocity.x, velocity.y);
              normalized.normalize();
          
              this.drot = (-90 + degrees(normalized.heading()) + 360) % 360;
          }
        }
        
        if (drot - rot < (360 - drot + rot)) {
            rot += (drot - rot) * (drotv / frameRate);
        } else {
            rot -= (360 - drot + rot) * (drotv / frameRate);
        }
    }
    
    boolean isHovering()  {
      if (mouseX >= (pos.x - 20) && mouseX <= (pos.x + 20) && mouseY >= (pos.y - 20) && mouseY <= (pos.y + 70)) {
            return true;   
  
      }
      return false;
    }
}
