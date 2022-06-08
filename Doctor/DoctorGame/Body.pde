class Body extends Object {
    PShape SVGShape;
    float drot;
    float drotv;
    float minrot;
    float maxrot;
    int moveCount;
    Body parent;
    PVector socket;
    Object bed;
    boolean bmirror = false;
        
    Body(PVector pos, float rot, String type, Body parent, Object bed) {
        super(pos, rot);
        SVGShape = loadShape(type);
        scale = .8;
        drot = rot;
        drotv = 90;
        minrot = -40;
        maxrot = 40;
        moveCount = 0;
        this.parent = parent;
        this.bed = bed;
    }
    
    void display() {
        super.display();
        
        SVGShape.disableStyle();
        fill(0);
        strokeWeight(1);
        stroke(255);
        
        pushMatrix();
        translate(bed.pos.x + pos.x - 580, bed.pos.y + pos.y - 410);
        pushMatrix();
        rotate(radians(rot));
        
        shape(SVGShape, 0, 0, SVGShape.width * scale, SVGShape.height * scale);
        strokeWeight(1);
        
        popMatrix();
        popMatrix();
    }
    
    void update() {
        super.update();
        
        if (parent != null) {
            this.pos.x = parent.getSocketPosition().x;
            this.pos.y = parent.getSocketPosition().y;
        }
        
        if (parent != null && bmirror) {
            drot = parent.drot * -1.2;
            rot = lerp(rot, drot, .01);
        } else {
            if (moveCount-- <= 0) {
                moveCount = (int)random(80, 100);
                drot = random(minrot, maxrot);
            }
            
            rot = lerp(rot, drot, .01);
        }
    }
    
    PVector getSocketPosition() {
        PVector newPos = new PVector(socket.x, socket.y);
        newPos.rotate(radians(rot));
        newPos.x += pos.x;
        newPos.y += pos.y;
        return newPos;
    }
}
