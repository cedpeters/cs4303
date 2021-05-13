class EventCareerFayre extends Event{

  public EventCareerFayre() {
    
    super(
      "Career Fayre (The Student Union)", 
      14, 
      17, 
      "The huge Club 601 has been turned into a claustrophobic collection of alleyways, each one lined with the tables belonging to prospective employers. Some students float through the room, grabbing free pens and socks and avoiding the eyes of recruiters. Others dominate the attention of the people in corporate shirts, labouriously pouring a checklist of accomplishments into captive ears."
    );
  }
  
  public void calcNextDialogue(String keyPressed) {
     currentView = 3; //Ready to move to next hour
  }
  
}
