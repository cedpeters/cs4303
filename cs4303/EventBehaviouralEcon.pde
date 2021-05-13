class EventBehaviouralEcon extends Event{

  public EventBehaviouralEcon() {
    
    super(
      "Behavioural Econ (Irvine Building)", 
      16, 
      18, 
      "The room is crowded full of students taking notes on all the ways people do not, in fact, behave rationally at all times."
    );
  }
  
  public void calcNextDialogue(String keyPressed) {
     currentView = 3; //Ready to move to next hour
  }
  
}
