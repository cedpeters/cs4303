class Description extends Block {
  public Description(float x, float y, float width, float height) {
    super(x, y, width, height);
  }
  
  void draw() {
    super.draw();
    
    fill(0, 102, 153);
    textAlign(CENTER, CENTER);
    text(possibleEvents[currentLoc].description, position.x, position.y, width, height);
  }
}
