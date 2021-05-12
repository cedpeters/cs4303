class InfoFlag extends Block {
  String info;
  
  public InfoFlag(float x, float y, float width, float height, String info) {
    super(x, y, width, height);
    this.info = info;
  }
  
  void draw() {
    super.draw();
    
    fill(0, 102, 153);
    textAlign(CENTER, CENTER);
    text(info, position.x, position.y, width, height);
  }
}
