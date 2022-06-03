class Monitor extends Object{
    
    PShape Monitor;

    int atp = 0;
    float stp = 1;
    float pdist = 4;
    int good[] = {10, 0, -10, 3, 0, 0, 0, 0, 0, 10, 0, -10, 3,  0, 0, 0, 0, 0};
    

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
        
        pushMatrix();
        translate(pos.x, pos.y);
        pushMatrix();
        rotate(radians(rot));
        shape(Monitor, 0, 0);
        strokeWeight(1);
        
        //line
        int n = good.length;
        for (int i = 0; i < good.length - 1; i++) {
            line(-44 + (i) % n * pdist, -265 + good[(atp + i) % n], -44 + ((i + 1) % n) * pdist, -265 + good[(atp + i + 1) % n]);
        }
        
        
        
        popMatrix();
        popMatrix();
    }
    
    void update() {
        
        if (frameCount % 7 == 0)
            atp += 1;
        
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
