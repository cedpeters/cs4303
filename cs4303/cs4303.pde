

//Blocks on the screen
ArrayList<Block> headerBlocks;
ArrayList<ArrayList<Block>> bodyBlocks;
Block header;
Block body;
float portionHeader = 0.1;


//Game status
String[] possibleViews = {"LocStart", "InConvo", "DoingPuzzle", "EventEnd"};
int currentView;
boolean keepOldDialogue;

ArrayList<Event> possibleNextEvents;

int currentDay;

ArrayList<Event> possibleEvents;
Event currentLoc;

int startTime;
int sleepTime;
int currentTime;

String latestDialogue;

void setup() {
  
  fullScreen();
  
  startTime = 8;
  sleepTime = 22;
  currentTime = 8;
  currentView = 0;
  keepOldDialogue = true;
  currentDay = 1;
  
  possibleNextEvents = new ArrayList();
  
  possibleEvents = new ArrayList();
  possibleEvents.add(new DormEvent(startTime, sleepTime));
  possibleEvents.add(new Event("Econometrics Lecture", 9, 10, "An interesting choice. Ten minutes of chatting with your friends in exchange for 45 minutes of regretting your second subject of study."));
  possibleEvents.add(new Event("Disney Pub Quiz", sleepTime-2, sleepTime-1, "Do you know enough to win the pub quiz?"));
  possibleEvents.add(new Event("Club 601", sleepTime - 4, sleepTime - 1, "You're sticky and you have a headache, but hey - they're playing your favourite song!"));
    
  currentLoc = possibleEvents.get(0);
  
  
  //Make the Blocks in the header
  headerBlocks = new ArrayList();
  
  this.header = new Block(0, 0, displayWidth, displayHeight*portionHeader);
  
  Block clock = new Clock(header.position.x, header.position.y, header.width * 0.33, header.height);
  Block day = new Day(clock.position.x + clock.width, header.position.y, header.width * 0.33, header.height);
  Block location = new LocationBlock(day.position.x + day.width, header.position.y, header.width - (clock.width + day.width), header.height);
  
  //blocks.add(header);
  headerBlocks.add(clock);
  headerBlocks.add(day);
  headerBlocks.add(location);
  
  //Make all the Blocks in the body
  bodyBlocks = new ArrayList();
  this.body = new Block(0, displayHeight*portionHeader, displayWidth, displayHeight - (displayHeight * portionHeader));
  
  //Start of Location
  Block schedule = new Schedule(body.position.x, body.position.y, body.width * 0.25, body.height);
  Block description = new Description(schedule.position.x + schedule.width, body.position.y, body.width * 0.5, body.height/2);
  Block dialogueMenu = new DialogueMenu(schedule.position.x + schedule.width, body.position.y + description.height, body.width * 0.5, body.height/2);
  Block stats = new Stats(description.position.x + description.width, body.position.y, body.width - (schedule.width + description.width), body.height);
  
  ArrayList locStart = new ArrayList();
  locStart.add(schedule);
  locStart.add(description);
  locStart.add(dialogueMenu);
  locStart.add(stats);
  bodyBlocks.add(locStart);
  
  //In Conversation
  Block personName = new InfoFlag(body.position.x, body.position.y, body.width, body.height * 0.05, "Person's Name");
  Block dialogueM = new DialogueMenu(body.position.x, body.position.y + personName.height, body.width * 0.7, body.height);
  Block notes = new Notes(dialogueM.position.x + dialogueM.width, body.position.y + personName.height, body.width - (body.width * 0.7), body.height);
  ArrayList inConvo = new ArrayList();
  inConvo.add(personName);
  inConvo.add(dialogueM);
  inConvo.add(notes);
  bodyBlocks.add(inConvo);
  
  //Doing Puzzle
  Block puzzleStats = new PuzzleStats(body.position.x, body.position.y, body.width, body.height * 0.05);
  Block puzzle = new Puzzle(body.position.x, body.position.y + puzzleStats.height, body.width, body.height - (puzzleStats.height));
  ArrayList doingPuzzle = new ArrayList();
  doingPuzzle.add(puzzleStats);
  doingPuzzle.add(puzzle);
  bodyBlocks.add(doingPuzzle);
  
  //End of event mimics the start of one.
  bodyBlocks.add(locStart);
  
}

void draw() {
  
  calcNextDialogue(null);
  calcDialogueOptions();
  
  //Print header blocks
  for(Block b : headerBlocks) b.draw();
  
  for(Block b : bodyBlocks.get(currentView)) b.draw();
}

void calcNextDialogue(String keyPressed) {
  
   if(currentLoc.location.equals("Dorm Room")) {
     //Initial day
     if(currentDay == 1) {
       //Continuing the conversation by hitting "C"
       if(keyPressed != null && keyPressed.equals("C")) {
         latestDialogue = "C: At the end of each hour you will be offered the chance to attend any event currently happening on your calendar. " + 
         "\nType the letter next to the event you wish to attend and you will be transported there." + 
         "\nP: What is my goal here? How do I win the game?" + 
         "\nC: Today is meant for exploring. I will explain the details later. Maybe . . . tomorrow.";
         currentView = 3;
         keepOldDialogue = true;
       }
       //First dialogue
       else if(latestDialogue == null) {
         latestDialogue = "C: Good morning, Enya. Welcome to your new life." +
         "\nE: Wh-where am I? What's going on?" + 
         "\nC: You're in St Andrews. It's Friday of week 4 and you're in your first day here out of many." + 
         "\nHit your C key to continue this conversation.";
       }
     }
   }
}

void calcDialogueOptions() {
  
  //TODO: DEAL WITH END OF DAY
  
  //If the event has ended and new event options are being displayed
 if(currentView == 3) {
   if(keepOldDialogue == false) latestDialogue = "";
   if(possibleNextEvents.size() != 0) return;
   latestDialogue += "\n\nChoose where you would like to be for the next hour: ";
   for(Event e : possibleEvents) {
     if(e.startTime <= currentTime + 1 && e.endTime >= currentTime + 2) {
       possibleNextEvents.add(e); //todo: clear when move to a new location
       latestDialogue += "\n" + possibleNextEvents.size() + ": " + e.location;
     }
   }
   
   
 }
}

void advanceToNextEvent(Event e) {
  possibleNextEvents = new ArrayList();
  currentView = 0;
  currentTime++;
  latestDialogue = null;
  currentLoc = e;
}

void mouseClicked() {
 currentView += 1;
 if(currentView > 3) currentView = 0;
}

void keyReleased() {
  if(key == 'c') calcNextDialogue("C");
  
  try {
    int num = Character.getNumericValue(key);
    
    //Make sure that we're in the end of an event, choosing a new one.
    if(currentView == 3 && possibleNextEvents.size() > 0) {
      if(num > possibleNextEvents.size()) return;
      
      advanceToNextEvent(possibleNextEvents.get(num - 1));
      return;
    }
  }
  
  catch(Exception e)  {System.out.println("ERROR");}
}
