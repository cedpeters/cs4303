//Blocks on the screen
ArrayList<Block> bodyBlocks;
Header header;
Block body;
float portionHeader = 0.1;


//Game status
String[] possibleViews = {"LocStart", "InConvo", "DoingPuzzle", "EventEnd"}; //<>//

String[] dialogueResponseOptions;

ArrayList<String> possibleNextEvents;

ArrayList<Block> scheduleEntries; //TODO: reset to null when changing day

HashMap<Integer, ArrayList<String>> possibleEventsEachHour;

String currentLoc;

int startTime;
int sleepTime;
int currentTime;
int currentView;
boolean keepOldDialogue;
int currentDay;

Event events;

String latestDialogue;

void setup() {
  
  System.out.println("SETUP");
  
  fullScreen();
  
  System.out.println("FULLSCREEN");
  
  startTime = 8;
  sleepTime = 22;
  currentTime = 8;
  System.out.println("TIME: ");
  currentView = 0; //<>//
  keepOldDialogue = true;
  currentDay = 1;
    
  System.out.println("BEFORE EVENTS");
  
  events = new Event();
  
  System.out.println("EVENTS");
    
  //TODO: add requirements to unlock some events on calendar.
  currentLoc = events.getFirstLocOfDay();
  
  
  //Make the Blocks in the header
  this.header = new Header(0, 0, displayWidth, displayHeight*portionHeader);
  
  //Make all the Blocks in the body
  bodyBlocks = new ArrayList();
  
  float bodyX = 0;
  float bodyY = displayHeight * portionHeader;
  float bodyWidth = displayWidth;
  float bodyHeight = displayHeight - (displayHeight * portionHeader);
  
  Block locStart = new LocStart(bodyX, bodyY, bodyWidth, bodyHeight);
  Block inConvo = new InConvo(bodyX, bodyY, bodyWidth, bodyHeight);
  Block doingPuzzle = new DoingPuzzle(bodyX, bodyY, bodyWidth, bodyHeight);

  //End of event mimics the start of one.
  bodyBlocks.add(locStart);
  bodyBlocks.add(inConvo);
  bodyBlocks.add(doingPuzzle);
  bodyBlocks.add(locStart); //the end is identical to the start (todo: maybe change)
  
}

void draw() {
  
  System.out.println("DRAW");
    
  calcNextDialogue(null);
  
  header.draw();
  
  bodyBlocks.get(currentView).draw();
    
}

void calcNextDialogue(String keyPressed) {
  
  if(currentView == 2) {
   //todo: deal with puzzle view
  }
  
  //End of an event: choose next location
  else if(currentView == 3) {
    
    //It's time to move on but the player hasn't entered a command yet
    if(keyPressed == null) {
       if(possibleNextEvents != null) return; //If this has already been done, don't recreate the wheel
       
       possibleNextEvents = new ArrayList();
       
       if(keepOldDialogue == false) latestDialogue = "";
       
       int newStartTime = events.endTimeOf(currentLoc);
       
       latestDialogue += "\n\nChoose where you would like to be start at time " + newStartTime + ":"; 
       
       for(String e : possibleEventsEachHour.get(newStartTime)) {
         possibleNextEvents.add(e);
         latestDialogue += "\n" + possibleNextEvents.size() + ": " + e;
       }
     }
    
     else {
       int num = Integer.parseInt(keyPressed);
       
       if(num > possibleNextEvents.size()) return;
      
        advanceToNextEvent(possibleNextEvents.get(num - 1));
     }
  }
  
  else events.calcNextDialogue(keyPressed);
}

void advanceToNextEvent(String e) {
  possibleNextEvents = null;
  currentView = 0;
  currentTime++;
  latestDialogue = null;
  currentLoc = e;
}

void keyReleased() {
  if(key == 'c') calcNextDialogue("C");
  
  try {
    int num = Character.getNumericValue(key);
    System.out.println("NUM: " + num);
    
    calcNextDialogue(String.valueOf(key));
 
  }
  
  catch(Exception e)  {System.out.println("ERROR");}
}
