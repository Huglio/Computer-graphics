class Monitor extends Object{
    
    PShape Monitor;

    float x_speed;
    float y_speed;

    Monitor(PVector pos, float rot) {
        super(pos, rot);
        Monitor = loadShape("HeartbeatMonitor.svg");
        x_speed = random(-3.5, 3.5);
        y_speed = random(-3, -5);
        this.rot = -10 * x_speed / 3.5;
    }
    
    void display() {
        super.display();
        
        Monitor.disableStyle();
        fill(0);
        strokeWeight(1);
        stroke(255);
        
        translate(pos.x, pos.y);
        pushMatrix();
        rotate(radians(rot));
        shape(Monitor, 0, 0);
        popMatrix();
    }
    
    void update() {
        pos.x += x_speed;
        pos.y += y_speed;
        
        
        if (pos.y > height) {
            y_speed *= -.4;
            pos.y = height;
        }
        
        rot *= .9;
        
        x_speed *= .97;
        y_speed += 10 / frameRate;
    }
}
