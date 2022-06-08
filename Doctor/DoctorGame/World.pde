class World {
    
    ArrayList<Object> objects;
    ArrayList<Interactable> interactable;
    
    World() {
        objects = new ArrayList<Object>();
        interactable = new ArrayList<Interactable>();
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
