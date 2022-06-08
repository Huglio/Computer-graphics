class Monitor extends Interactable {
    
    PShape Monitor;

    int atp = 0;
    float stp = 1;
    float pdist = 5;
    int good[] = {10, 0, -10, 3, 0, 0, 0, 0, 0, 10, 0, -10, 3,  0, 0, 0, 0, 0};
    int fibr[] = {-10, 5, -6, 5, -6, 4, -2, 6, -1, 3, -2, -5, 6, -3, -1, 6, 3, 6};
    int dead[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

    float x_speed;
    float y_speed;

    Monitor(PVector pos, float rot) {
        super(pos, rot);
        Monitor = loadShape("HeartbeatMonitor.svg");
        x_speed = random(-3.5, 3.5);
        y_speed = random(-3, -5);
        this.rot = -10 * x_speed / 3.5;
        scale = 1;
    }
    
    void display() {
        super.display();
        
        Monitor.disableStyle();
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
        
        shape(Monitor, 0, 0, Monitor.width * scale, Monitor.height * scale);
        strokeWeight(1);
        
        //line
        

        
        int n = good.length;
        for (int i = 0; i < good.length - 1; i++) {
            line((-44 + (i) % n * pdist) * scale, (-265 + good[(atp + i) % n]) * scale, (-44 + ((i + 1) % n) * pdist) * scale, (-265 + good[(atp + i + 1) % n]) * scale);
        }
        
        fill(255);
        text("70", 20 * scale, -285 * scale);
        
        popMatrix();
        popMatrix();
    }
    
    void update() {
        
        if (frameCount % 7 == 0)
            atp += 1;
        
        if (selected) {
          
          pos.x = mouseX + mouseRelative.x;
          pos.y = mouseY + mouseRelative.y;
          
          float x = mouseX - pmouseX;
          float y = mouseY - pmouseY;
          
          x_speed = x;
          y_speed = y;
        } else {
        
          pos.x += x_speed;
          pos.y += y_speed;
        
        
          if (pos.y > height) {
              y_speed *= -.4;
              pos.y = height;
          }
          if (pos.y - 270 < 0) {
              y_speed *= -.4;
              pos.y = 270;
          }
          if (pos.x - 50 < 0) {
              x_speed *= -.4;
              pos.x = 50;
          }
          if (pos.x + 50 > width) {
              x_speed *= -.4;
              pos.x = width - 50;
          }
                
          rot *= .9;
        
          x_speed *= .97;
          y_speed += 20 / frameRate;
        }
    }
    
    boolean isHovering()  {
      if (mouseX >= (pos.x - 50) && mouseX <= (pos.x + 50) && mouseY >= (pos.y - 270) && mouseY <= pos.y) {
            return true;   
  
      }
      return false;
    }
}
