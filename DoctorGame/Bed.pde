class Bed extends Object {
    PShape Bed;

    
    Bed(PVector pos, float rot) {
        super(pos, rot);
        Bed = loadShape("Bed.svg");
    }
    
    void display() {
        Bed.disableStyle();
        fill(0);
        strokeWeight(1);
        stroke(255);
        
        pushMatrix();
        translate(pos.x, pos.y);
        pushMatrix();
        rotate(radians(rot));
        shape(Bed, 0, 0);
        popMatrix();
        popMatrix();
    }
    
    void update() {
        
    }
}
