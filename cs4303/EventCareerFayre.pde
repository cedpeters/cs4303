class EventDinner extends Event{

  public EventDinner() {
    
    super(
      "Dinner (Uni Hall)", 
      17, 
      18, 
      "The room is bustling full of friends calling greetings to each other, walking over to say hi, and chattering about their days. The food is less heartwarming."
    );
  }
  
  public void calcNextDialogue(String keyPressed) {
     currentView = 3; //Ready to move to next hour
  }
  
}
