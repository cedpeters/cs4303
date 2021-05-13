class EventJPMorgan extends Event{

  public EventJPMorgan() {
    
    super(
      "JP Morgan Talk (Hotel Du Vin)", 
      12, 
      14, 
      "The fancy room is full of people in suits and nice dresses. There are beautiful vases of flowers on tables in the corners of the room. Looking more closely, you can see the streaks of sweat on the faces of older students, the wide smiles on their faces when they talk to recruiters a bit too constant to be genuine."
    );
  }
  
  public void calcNextDialogue(String keyPressed) {
     currentView = 3; //Ready to move to next hour
  }
  
}
