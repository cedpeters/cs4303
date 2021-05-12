class EventEconHistory extends Event{

  public EventEconHistory() {
    
    super(
      "Economic History (Upper College Lawn)", 
      13, 
      15, 
      "The only module where listening to \'Hamilton\' counts as background research."
    );
  }
  
  public void calcNextDialogue(String keyPressed) {
     currentView = 3; //Ready to move to next hour
  }
  
}
