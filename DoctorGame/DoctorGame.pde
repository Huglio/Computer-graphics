
World world;
Monitor monitor;
Bed bed;

void setup() {
    size(1000, 500);
    world = new World();
    
    monitor = new Monitor(new PVector(width / 2, height), 0);
    bed = new Bed(new PVector(width / 4, height), 0);
}

void draw() {
    background(0);
    
    
    world.display();
    world.update();
    
    fill(255);
    circle(0, 0, 25);

}
