class EventHouseParty extends Event{

  public EventHouseParty() {
    
    super(
      "House Party (The Badlands)", 
      18, 
      22, 
      "You're sticky and you have a headache, but hey - they're playing your favourite song!"
    );
  }
  
  public void calcNextDialogue(String keyPressed) {
     currentView = 3; //Ready to move to next hour
  }
  
}
