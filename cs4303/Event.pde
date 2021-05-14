class Event {
  
  HashMap<String, int[]> eventNameToTimes = new HashMap();
  HashMap<String, String> eventNameToDescription = new HashMap();
  
  public Event() {
    //Events which are always available
    eventNameToTimes.put("Behavioural Econ (Irvine Building)", new int[]{16,18, 1});
    eventNameToDescription.put("Behavioural Econ (Irvine Building)", "The room is crowded full of students taking notes on all the ways people do not, in fact, behave rationally at all times.");
    
    eventNameToTimes.put("Dorm Room", new int[]{startTime, sleepTime-1, 1});
    eventNameToDescription.put("Dorm Room", "Welcome to your dorm room! This is your safe, quiet space. No one will bother you here (besides me, of course - no getting away from the narrator!), but you'll never get out of the game by staying here all day every day, either.");
    
    eventNameToTimes.put("Econometrics Lecture (Upper College Lawn)", new int[]{9, 11, 1});
    eventNameToDescription.put("Econometrics Lecture (Upper College Lawn)", "An interesting choice. Ten minutes of chatting with your friends in exchange for 45 minutes of wondering why anyone would voluntarily subject themselves to statistics courses.");

    eventNameToTimes.put("Economic History Tutorial (Castlecliffe)", new int[]{18, 19, 1});
    eventNameToDescription.put("Economic History Tutorial (Castlecliffe)", "You\'re in a beautiful building next to the sea, though there\'s no window in this tutorial room. You nab a seat by the beautiful bricked up fireplace and listen to a discussion about the cyclical under-regulation of banks.");

    eventNameToTimes.put("Dinner (Uni Hall)", new int[]{17, 18, 1});
    eventNameToDescription.put("Dinner (Uni Hall)", "The room is bustling full of friends calling greetings to each other, walking over to say hi, and chattering about their days. The food is less heartwarming.");

    eventNameToTimes.put("Breakfast (Uni Hall)", new int[]{9, 10, 1});
    eventNameToDescription.put("Breakfast (Uni Hall)", "There\'s nothing like the smell of fried food in the morning. Help yourself to a full plate of haggis, potatoes and bacon and have a seat at your usual table. It looks pretty empty today.");

    eventNameToTimes.put("Lunch (Uni Hall)", new int[] {13, 14, 1});
    eventNameToDescription.put("Lunch (Uni Hall)", "Today\'s lunch options are pizza, baked potato or macaroni & cheese with a side of chips, garlic bread, and peas. Yum.");
    
    eventNameToTimes.put("Economic History (Upper College Lawn)", new int[] {13, 15, 1});
    eventNameToDescription.put("Economic History (Upper College Lawn)", "The only module where listening to \'Hamilton\' counts as background research.");
}
  
  
  public void calcNextDialogue(String keyPressed) {
    switch(currentLoc) {
      case "Breakfast (Uni Hall)":
        calcNextDialogueBreakfast(keyPressed);
        break;
      case "Dorm Room":
        calcNextDialogueDormRoom(keyPressed);
        break;
      case "Dinner (Uni Hall)":
        calcNextDialogueDinner(keyPressed);
        break;
      default: 
        changeView(3); //move to the next hour
    }
  }
  
  public String getFirstLocOfDay() {
   return "Dorm Room"; 
  }
  
  public String getDescription(String e) {
   return eventNameToDescription.get(e); 
  }
  
  public int endTimeOf(String e) {
    if(e.equals("Dorm Room")) return currentTime + 1;
    return eventNameToTimes.get(e)[1]; 
  }
  
  //************************Breakfast*****************************
  private void calcNextDialogueBreakfast(String keyPressed) {
    latestDialogue = "*Stefan plops into his usual seat next to you, brown hair tousled and eyes still a bit glazed with sleep.*"
    + "\nStefan: 'Morning"
    + "\nEnya: Good morning, Stefan. You look tired. Were you out late last night?"
    + "\nStefan: No, I just stayed up too late watching YouTube as usual. Then I got butt-dialed right when I was getting in bed."
    + "\nEnya: Yikes, really? Who was it?"
    + "\nStefan: It was Peter. Dunno why I ever signed up to be a mentor in my fourth year, he's such a pain. He was on a night out, super wasted, babbling about how much his missed his sister of all things."
    + "\nEnya: Aw, I'm sorry about that.";
  }
  
  //*************************Dinner********************************
  private void calcNextDialogueDinner(String keyPressed) {
    changeView(3);
  }
  
  //*************************Dorm Room*****************************
  private void calcNextDialogueDormRoom(String keyPressed) {
     if(currentDay == 1) firstDayDorm(keyPressed);
     
     else if(currentDay == 2 && currentTime == startTime) secondDayMorning(keyPressed); 
     
     else regularDayDorm(keyPressed);
     
     //Todo: add the dialogue for after solving the final puzzle (i.e. winning!)
     
     //todo: else regularDay(keyPressed); - can take a nap or work on puzzle
     
     //todo: currentDay == 3 (explain the rules of the game)
  }
  
    private void firstDayDorm(String keyPressed) {
    
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
       "\nC: Today is meant for exploring. I will explain the details tomorrow morning.";
       currentView = 3;
       keepOldDialogue = true;
      }
    }
  }
  
  private void secondDayMorning(String keyPressed) {
        
    //Start of the location
    if(latestDialogue == null) {
         latestDialogue = "C: Good morning and welcome to your second day in the game. Did you have a good time yesterday?"
         +"\n1: No, that was horrible." + 
         "\n2: Yes, I guess."; 
         
         dialogueResponseOptions = new String[]{
           "\nThat\'s too bad. I'm afraid you'll need to learn how to appreciate the fine points of a mundane day" + 
           "\nin order to get out of here.",
           "\nThat\'s good. Try to hold onto that."
         };
         
         String explanation = "In order to get out of the game, you need to solve three puzzles. Convince three people to lend you a prized possession, then bring those items here to solve the puzzle attached to each one. You will lose your puzzle pieces at the end of each day.";
         
         dialogueResponseOptions[0] += explanation;
         dialogueResponseOptions[1] += explanation;
   }
     
     //Don't do anything until the key is pressed.
     
     //Once the key is pressed, if it's a valid answer, respond and end the dialogue.
     if(keyPressed != null) {
       int numPressed = Integer.parseInt(keyPressed);
                           
       if(dialogueResponseOptions != null && numPressed > 0 && numPressed <= dialogueResponseOptions.length) {
         latestDialogue += dialogueResponseOptions[numPressed - 1];
         changeView(3);
         dialogueResponseOptions = null;
       }
       
       else return;
     }
  }
  
  private void regularDayDorm(String keyPressed) {
    if(gatheredPuzzles.size() == 0) {
      latestDialogue = "C: Welcome back to your dorm room. I\'m afraid there\'s not much to do here right now. Go find some prized items.";
      changeView(3);
    }
    
    else {
      //todo: if all puzzles are solved, just give a stats update. Otherwise, give stats update and provide option to solve a puzzle or move to next event.
    }
  }
  
  
}

/*

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

class EventCareerWork extends Event{

  public EventCareerWork() {
    
    super(
      "Career Workshop (Careers Centre)", 
      10, 
      11, 
      "About twenty people crowd into a small room, perching on couches and standing by them. Before the talk starts, everyone focuses on grabbing as many free pens, pamphlets, and books as they can discreetly shove in their bags."
    );
  }
  
  public void calcNextDialogue(String keyPressed) {
     currentView = 3; //Ready to move to next hour
  }
  
}

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

class EventDiplomat extends Event{

  public EventDiplomat() {
    
    super(
      "US Diplomat Talk (Medical Building)", 
      9, 
      10, 
      "The environment is uncomfortably stuffy, and everyone seems to be dressed nicer than you."
    );
  }
  
  public void calcNextDialogue(String keyPressed) {
     currentView = 3; //Ready to move to next hour
  }
  
}
*/
