class EventEconometrics extends Event{

  public EventEconometrics() {
    
    super(
      "Econometrics Lecture (Upper College Lawn)", 
      9, 
      11, 
      "An interesting choice. Ten minutes of chatting with your friends in exchange for 45 minutes of wondering why anyone would voluntarily subject themselves to statistics courses."
    );
  }
  
  public void calcNextDialogue(String keyPressed) {
     currentView = 3; //Ready to move to next hour
  }
  
}
