class World {
  ArrayList<Object> objs;
  ArrayList<Button> buttons;
  ArrayList<Node> nodes;
  
  World() {
    objs = new ArrayList<Object>();
    buttons = new ArrayList<Button>();
    nodes = new ArrayList<Node>();
  }
  
  void addObj(Object obj) {
    objs.add(obj);
  }
  
  void removeObj(Object obj) {
    objs.remove(obj);
  }
  
  void addButton(Button button) {
    buttons.add(button);
  }
  
  void removeButton(Button button) {
    buttons.remove(button);
  }
  
  void addNode(Node node) {
    nodes.add(node);
  }
  
  void removeNode(Node node) {
    nodes.remove(node);
  }
  
  void display() {
    for (Object x : objs)
      x.display();
  }
  
  void update() {
    for (Object x : objs)
      x.update();
  }
}

World world = new World();
