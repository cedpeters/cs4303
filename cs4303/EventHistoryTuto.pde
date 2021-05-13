class EventHistoryTut extends Event{

  public EventHistoryTut() {
    
    super(
      "Economic History Tutorial (Castlecliffe)", 
      18, 
      19, 
      "You\'re in a beautiful building next to the sea, though there\'s no window in this tutorial room. You nab a seat by the beautiful bricked up fireplace and listen to a discussion about the cyclical under-regulation of banks."
    );
  }
  
  public void calcNextDialogue(String keyPressed) {
     currentView = 3; //Ready to move to next hour
  }
  
}
