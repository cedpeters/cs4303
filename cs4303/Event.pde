class Event {
  String location;
  String description;
  int beginTime;
  int endTime;
  boolean unlocked;
  
  HashMap<String, int[]> eventNameToTimes = new HashMap();
  HashMap<String, String> eventNameToDescription = new HashMap();
  
  public Event() {
    eventNameToTimes.put("Behavioural Econ (Irvine Building)", new int[]{16,18, 1});
    eventNameToDescription.put("Behavioural Econ (Irvine Building)", "The room is crowded full of students taking notes on all the ways people do not, in fact, behave rationally at all times.");
    
    eventNameToTimes.put("Dorm Room", new int[]{startTime, sleepTime-1, 1});
    eventNameToDescription.put("Dorm Room", "Welcome to your dorm room! This is your safe, quiet space. No one will bother you here (besides me, of course - no getting away from the narrator!), but you'll never get out by staying here all day every day, either.");
    
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
  
  public Event(String location, int startTime, int endTime, String description) {
    System.out.println("MAKING EVENT: " + location);
    this.location = location;
    this.description = description;
    this.beginTime = startTime;
    this.endTime = endTime;
    this.unlocked = false;
  }
  
  public Event(String location, int startTime, int endTime, String description, boolean unlocked) {
    this(location, startTime, endTime, description);
    this.unlocked = unlocked;
  }
  
  public void calcNextDialogue(String keyPressed) {
    System.out.println("KEY PRESSED: " + keyPressed);
    changeView(3); //Default is to move to next hour
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
