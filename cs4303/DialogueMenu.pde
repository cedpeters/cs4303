class DialogueMenu extends Block {
  public DialogueMenu(float x, float y, float width, float height) {
    super(x, y, width, height);
  }
  
  void draw() {
    super.draw();
    
    fill(0, 102, 153);
    textAlign(CENTER, CENTER);
    try {
    text(latestDialogue, position.x + (width/2), position.y + (height/2));
    }
    catch(NullPointerException e) {
      text("Dialogue Box", position.x + (width/2), position.y + (height/2));
    }
  }
}
