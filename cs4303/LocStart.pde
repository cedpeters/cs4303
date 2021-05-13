class LocStart extends Block{
    
  Schedule schedule;
  Block description;
  Block dialogueMenu;
  Block stats;
  
  public LocStart(float x, float y, float width, float height) {
    super(x, y, width, height);
    
    schedule = new Schedule(x, y, width * 0.25, height);
    description = new Block(schedule.position.x + schedule.width, y, width * 0.5, height / 2);
    dialogueMenu = new Block(schedule.position.x + schedule.width, y + description.height, width * 0.5, height / 2);
    stats = new Block(description.position.x + description.width, y, width - (schedule.width + description.width), height);
  }
  
 
 public void draw() {
   schedule.draw();
   
   fill(0, 102, 153);
   textAlign(CENTER, CENTER);
   
   
   description.draw(events.getDescription(currentLoc));
   
   try {
     dialogueMenu.draw(latestDialogue);
   }
   catch(Exception e) {
     dialogueMenu.draw("Dialogue Menu");
   };
   stats.draw("Statistics");
 }
}
