class Day extends Block {
  public Day(float x, float y, float width, float height) {
    super(x, y, width, height);
  }
  
  void draw() {
    super.draw();
    
    fill(0, 102, 153);
    textAlign(CENTER, CENTER);
    text("Day " + currentDay, position.x + (width/2), position.y + (height/2));
  }
}
