class EventCareerWork extends Event{

  public EventCareerWork() {
    
    super(
      "Career Workshop (Careers Centre)", 
      10, 
      11, 
      "About twenty people crowd into a small room, perching on couches and standing by them. Before the talk starts, everyone focuses on grabbing as many free pens, pamphlets, and books as they can discreetly shove in their bags."
    );
  }
  
  public void calcNextDialogue(String keyPressed) {
     currentView = 3; //Ready to move to next hour
  }
  
}
