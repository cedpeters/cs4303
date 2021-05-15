class Block {
  
  public PVector position;
  
  String text;
    
  //The width and height are used to define the area around the point mass particle which counts as part of the Particle
  public float width;
  public float height;
    
  public Block(float x, float y, float width, float height) {
    this.position = new PVector(x, y);
    this.width = width;
    this.height = height;
  }
  
  public Block(float x, float y, float width, float height, String text) {
    this(x, y, width, height);
    this.text = text;
  }
  
  void draw() {
    fill(color(192, 207, 203));
    rect(position.x, position.y, width, height);
    if(this.text != null) {
      fill(0, 102, 153);
      textAlign(CENTER, CENTER);
      text(text, position.x, position.y, width, height);
    }
  }
  
  void draw(String text) {
    this.text = text;
    draw();
    this.text = null;
  }
}
