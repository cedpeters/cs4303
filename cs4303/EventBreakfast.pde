class EventBreakfast extends Event{

  public EventBreakfast() {
    
    super(
      "Breakfast (Uni Hall)", 
      9, 
      10, 
      "There\'s nothing like the smell of fried food in the morning. Help yourself to a full plate of haggis, potatoes and bacon and have a seat at your usual table. It looks pretty empty today."
    );
  }
  
  public void calcNextDialogue(String keyPressed) {
     currentView = 3; //Ready to move to next hour
  }
  
}
