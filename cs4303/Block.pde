class Block {
  
  public PVector position;
    
  //The width and height are used to define the area around the point mass particle which counts as part of the Particle
  public float width;
  public float height;
    
  public Block(float x, float y, float width, float height) {
    this.position = new PVector(x, y);
    this.width = width;
    this.height = height;
  }
  
  void draw() {
    fill(color(255, 0, 255));
    rect(position.x, position.y, width, height);
  }
  
  void draw(String text) {
    draw();
    fill(0, 102, 153);
    textAlign(CENTER, CENTER);
    text(text, position.x + (width/2), position.y + (height/2));
  }
}
