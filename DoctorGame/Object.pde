class Object {
    PVector pos;
    float scale;
    float rot;

    boolean render = true;

    Object(PVector pos, float rot) {
        world.objects.add(this);
        
        this.pos = new PVector(pos.x, pos.y);
        this.rot = rot;
    }
    
    void destroy() {
        world.objects.remove(this);
    }
    
    void display() {
        
    }
    
    void update() {
        
    }
}
