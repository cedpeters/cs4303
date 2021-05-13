class EventDiplomat extends Event{

  public EventDiplomat() {
    
    super(
      "US Diplomat Talk (Medical Building)", 
      9, 
      10, 
      "The environment is uncomfortably stuffy, and everyone seems to be dressed nicer than you."
    );
  }
  
  public void calcNextDialogue(String keyPressed) {
     currentView = 3; //Ready to move to next hour
  }
  
}
