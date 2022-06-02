class World {
    
    ArrayList<Object> objects;
    
    World() {
        objects = new ArrayList<Object>();
    }
    
    void display() {
        for (Object x : objects) {
            if (x.render)
                x.display();
        }
    }
    
    void update() {
        for (Object x : objects) {
            x.update();
        }
    }
}
