class Person extends Object {
    
    Body head;
    Body body;
    Body uleg;
    Body lleg;

    Body uleg2;
    Body lleg2;
    
    Body uarm;

    Person(PVector pos, float rot, Object bed) {
        super(pos, rot);
        
        body = new Body(new PVector(width / 2, height / 2), 0, "C_Chest.svg", null, bed);
        body.minrot = -10;
        body.socket = new PVector(-60, -50);
    
        head = new Body(new PVector(width / 2, height / 2), 0, "C_Head.svg", body, bed);
    
        uleg = new Body(new PVector(width / 2, height / 2), 0, "C_ULeg.svg", null, bed);
        uleg.socket = new PVector(50, -30);
        lleg = new Body(new PVector(0, 0), 0, "C_LLeg.svg", uleg, bed);
        lleg.bmirror = true;
 
        uleg2 = new Body(new PVector(width / 2, height / 2), 0, "C_ULeg.svg", null, bed);
        uleg2.socket = new PVector(50, -30);
        lleg2 = new Body(new PVector(0, 0), 0, "C_LLeg.svg", uleg2, bed);
        lleg2.bmirror = true;
        
        uarm = new Body(new PVector(0, 0), 0, "C_UArm.svg", body, bed);
    }
    
    void display() {
        
    }
    
    void update() {
        
    }
}
