class LocationBlock extends Block {
  public LocationBlock(float x, float y, float width, float height) {
    super(x, y, width, height);
  }
  
  void draw() {
    super.draw();
    
    fill(0, 102, 153);
    textAlign(CENTER, CENTER);
    text(possibleLocations[currentLoc].name, position.x + (width/2), position.y + (height/2));
  }
}
