class EventDorm extends Event{

  public EventDorm() {
    
    super(
      "Dorm Room", 
      startTime, 
      sleepTime - 1, 
      "Welcome to your dorm room! This is your safe, quiet space. No one will bother you here (besides me, of course - no getting away from the narrator!), but you'll never get out by staying here all day every day, either."
    );
  }
  
  public void calcNextDialogue(String keyPressed) {
     if(currentDay == 1) firstDay(keyPressed);
     
     else if(currentDay == 2) secondDay(keyPressed);  
     
     //Todo: add the dialogue for after solving the final puzzle (i.e. winning!)
     
     //todo: else regularDay(keyPressed); - can take a nap or work on puzzle
     
     //todo: currentDay == 3 (explain the rules of the game)
  }
  
  private void firstDay(String keyPressed) {
    
    //Dialogue when you arrive to the location
    if(latestDialogue == null) {
      
      //The very first dialogue of the game
      if(currentTime == 8) {
        latestDialogue = "C: Good morning, Enya. Welcome to your new life." +
         "\nE: Wh-where am I? What's going on?" + 
         "\nC: You're in St Andrews. It's Friday of week 4 and you're in your first day here out of many." + 
         "\nType \'C\' to continue this conversation.";
      }
      
      //The dialogue that greets you on subsequent visits to the location
      else {
       latestDialogue = "C: Welcome back to your dorm room. I\'m afraid there\'s not much to do here, today.";
       currentView = 3;
      }
    }
    
    //Subsequent Dialogue
    else {
      //If no key has been pressed, don't change anything.
      
      //If key has been pressed, deal with it.
      if(keyPressed != null && keyPressed.equals("C")) {
        latestDialogue = "C: At the end of each hour you will be offered the chance to attend any event currently happening on your calendar. " + 
       "\nType the letter next to the event you wish to attend and you will be transported there." + 
       "\nP: What is my goal here? How do I win the game?" + 
       "\nC: Today is meant for exploring. I will explain the details later. Maybe . . . tomorrow.";
       currentView = 3;
       keepOldDialogue = true;
      }
    }
  }
  
  private void secondDay(String keyPressed) {
    
    System.out.println("KEY ON SECOND DAY: " + keyPressed); 
    
    //Deal with any hour after the first one (the rest of this method is the first hour of the second day)
    if(currentTime != startTime) {
      latestDialogue = "C: Welcome back to your dorm room. I\'m afraid there\'s not much to do here, today.";
      currentView = 3;
      return;
    }
    
    //Start of the location
    if(latestDialogue == null) {
         latestDialogue = "C: Good morning and welcome to your second day in the game. Did you have a good time yesterday?"
         +"\n1: No, that was horrible." + 
         "\n2: Yes, I guess."; 
         
         dialogueResponseOptions = new String[]{
         "\nThat\'s too bad. I'm afraid you'll need to learn how to appreciate the fine points of a mundane day" + 
         "\nin order to get out of here. Until tomorrow!",
         "\nThat\'s good. Try to hold onto that "
       };
     }
     
     //Don't do anything until the key is pressed.
     
     //Once the key is pressed, if it's a valid answer, respond and end the dialogue.
     if(keyPressed != null) {
       int numPressed = Integer.parseInt(keyPressed);
                           
       if(dialogueResponseOptions != null && numPressed > 0 && numPressed <= dialogueResponseOptions.length) {
         latestDialogue += dialogueResponseOptions[numPressed - 1];
         currentView = 3;
         dialogueResponseOptions = null;
       }
       
       else return;
     }
  }
  
}
