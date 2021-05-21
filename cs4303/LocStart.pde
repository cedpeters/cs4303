class LocStart extends Block{
    
  Schedule schedule;
  Block description;
  Block dialogueMenu;
  //Block stats;
  
  public LocStart(float x, float y, float width, float height) {
    super(x, y, width, height);
    
    schedule = new Schedule(x, y, width * 0.25, height);
    description = new Block(schedule.position.x + schedule.width, y, width * 0.75, height / 4);
    dialogueMenu = new Block(schedule.position.x + schedule.width, y + description.height, width * 0.75, height - description.height);
  }
  
 
 public void draw() {
   textFont(smallFont);
   schedule.draw();
   textFont(bigFont);
   
   fill(0, 102, 153);
   textAlign(CENTER, CENTER);
   
   
   description.draw(currentLoc + ": " + events.getDescription(currentLoc));
   
   try {
     dialogueMenu.draw(latestDialogue);
   }
   catch(Exception e) {
     dialogueMenu.draw("Dialogue Menu");
   };
 }
}
