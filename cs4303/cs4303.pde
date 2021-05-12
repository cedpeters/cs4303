

//Blocks on the screen
ArrayList<ArrayList<Block>> bodyBlocks;
Header header;
Block body;
float portionHeader = 0.1;


//Game status
String[] possibleViews = {"LocStart", "InConvo", "DoingPuzzle", "EventEnd"};
int currentView;
boolean keepOldDialogue;

String[] dialogueResponseOptions;

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
  currentDay = 2;
  
  possibleNextEvents = new ArrayList();
  
  possibleEvents = new ArrayList();
  //possibleEvents.add(new Event());
  possibleEvents.add(new DormEvent());
  possibleEvents.add(new Event("Econometrics Lecture", 9, 10, "An interesting choice. Ten minutes of chatting with your friends in exchange for 45 minutes of regretting your second subject of study."));
  possibleEvents.add(new Event("Disney Pub Quiz", sleepTime-2, sleepTime-1, "Do you know enough to win the pub quiz?"));
  possibleEvents.add(new Event("Club 601", sleepTime - 4, sleepTime - 1, "You're sticky and you have a headache, but hey - they're playing your favourite song!"));
    
  currentLoc = possibleEvents.get(0);
  
  
  //Make the Blocks in the header
  
  this.header = new Header(0, 0, displayWidth, displayHeight*portionHeader);
  
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
  
  header.draw();
    
  for(Block b : bodyBlocks.get(currentView)) b.draw();
}

void calcNextDialogue(String keyPressed) {
  
  if(currentView == 2) {
   //todo: deal with puzzle view
  }
  
  //End of an event: choose next location
  else if(currentView == 3) {
    
    //It's time to move on but the player hasn't entered a command yet
    if(keyPressed == null) {
       if(possibleNextEvents.size() != 0) return; //If this has already been done, don't recreate the wheel
       if(keepOldDialogue == false) latestDialogue = "";
       
       latestDialogue += "\n\nChoose where you would like to be in the next hour: ";
       
       for(Event e : possibleEvents) {
         if(e.beginTime <= currentTime + 1 && e.endTime >= currentTime + 2) {
           possibleNextEvents.add(e); //todo: clear when move to a new location
           latestDialogue += "\n" + possibleNextEvents.size() + ": " + e.location;
         }
       }
     }
     
     else {
       int num = Integer.parseInt(keyPressed);
       
       if(num > possibleNextEvents.size()) return;
      
      advanceToNextEvent(possibleNextEvents.get(num - 1));
     }
  }
  
  else currentLoc.calcNextDialogue(keyPressed);
}

void advanceToNextEvent(Event e) {
  possibleNextEvents = new ArrayList();
  currentView = 0;
  currentTime++;
  latestDialogue = null;
  currentLoc = e;
}

//todo: will delete this, it's not actually part of the game.
void mouseClicked() {
 currentView += 1;
 if(currentView > 3) currentView = 0;
}

void keyReleased() {
  if(key == 'c') calcNextDialogue("C");
  
  try {
    int num = Character.getNumericValue(key);
    
    calcNextDialogue(String.valueOf(key));
 
  }
  
  catch(Exception e)  {System.out.println("ERROR");}
}
