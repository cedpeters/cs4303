class PersonName extends Block {
  public PersonName(float x, float y, float width, float height) {
    super(x, y, width, height);
  }
  
  void draw() {
    super.draw();
    
    fill(0, 102, 153);
    textAlign(CENTER, CENTER);
    text("The name of the person I'm in conversation with", position.x + (width/2), position.y + (height/2));
  }
}
