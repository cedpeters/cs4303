class Schedule extends Block {
  public Schedule(float x, float y, float width, float height) {
    super(x, y, width, height);
  }
  
  void draw() {
    super.draw();
        
    fill(0, 102, 153);
    textAlign(CENTER, CENTER);
    
    for(int n = 0; n <= (sleepTime - startTime); n++) {
     text((n + startTime < 10 ? "0" : "") + (n + startTime) + ":00", position.x + 20, position.y + 10 + (height * n / (sleepTime - startTime + 1))); 
    }
    
  }
}
