class InConvo extends Block{
    
  Block personName;
  Block dialogueMenu;
  Block notes;
  
  public InConvo(float x, float y, float width, float height) {
    super(x, y, width, height);
    
    personName = new Block(x, y, width, height * 0.05);
    dialogueMenu = new Block(x, y + personName.height, width * 0.7, height);
    notes = new Block(dialogueMenu.position.x + dialogueMenu.width, y + personName.height, width - (width * 0.7), height);
  }
  
 
 public void draw() {
   
   fill(0, 102, 153);
   textAlign(CENTER, CENTER);
    
    
   personName.draw("Person's Name");
   try {
     dialogueMenu.draw(latestDialogue);
   }
   catch(Exception e) {
     dialogueMenu.draw("Dialogue Menu");
   };
   
   notes.draw("Notes");
 }
}
