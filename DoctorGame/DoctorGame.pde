
World world;
Monitor monitor;

void setup() {
    size(500, 500);
    world = new World();
    
    monitor = new Monitor(new PVector(width / 2, height), 0);
}

void draw() {
    background(0);
    
    world.display();
    world.update();
}
