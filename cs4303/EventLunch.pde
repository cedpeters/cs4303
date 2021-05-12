class EventLunch extends Event{

  public EventLunch() {
    
    super(
      "Lunch (Uni Hall)", 
      13, 
      14, 
      "Today\'s lunch options are pizza, baked potato or macaroni & cheese with a side of chips, garlic bread, and peas. Yum."
    );
  }
  
  public void calcNextDialogue(String keyPressed) {
     currentView = 3; //Ready to move to next hour
  }
  
}
