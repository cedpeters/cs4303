//Blocks on the screen
ArrayList<Block> bodyBlocks;
Header header;
Block body;
float portionHeader = 0.1;


//Game status
String[] possibleViews = {"LocStart", "InConvo", "DoingPuzzle", "EventEnd"};
int currentView;
boolean keepOldDialogue;

String[] dialogueResponseOptions;

ArrayList<Event> possibleNextEvents;

ArrayList<Block> scheduleEntries; //TODO: reset to null when changing day

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
  possibleEvents.add(new EventDorm()); //<>//
  possibleEvents.add(new EventLunch());
  possibleEvents.add(new EventDinner());
  possibleEvents.add(new EventEconometrics());
  possibleEvents.add(new EventEconHistory());
  possibleEvents.add(new EventBehaviouralEcon());
  possibleEvents.add(new EventHistoryTut());
  possibleEvents.add(new EventDiplomat());
  possibleEvents.add(new EventCareerWork());
  possibleEvents.add(new EventJPMorgan());
  possibleEvents.add(new EventCareerFayre());
  possibleEvents.add(new EventHouseParty());
  possibleEvents.add(new EventBreakfast());
  possibleEvents.add(new EventDorm());
  
    
  //TODO: add requirements to unlock some events on calendar.
  currentLoc = possibleEvents.get(0);
  
  
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
       if(possibleNextEvents.size() != 0) return; //If this has already been done, don't recreate the wheel
       
       if(keepOldDialogue == false) latestDialogue = "";
       
       latestDialogue += "\n\nChoose where you would like to be in the next hour: ";
       
       for(Event e : possibleEvents) {
         if(!e.unlocked) continue;
         if(e.beginTime <= currentTime + 1 && e.endTime >= currentTime + 2) {
           possibleNextEvents.add(e);
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

void keyReleased() {
  if(key == 'c') calcNextDialogue("C");
  
  try {
    int num = Character.getNumericValue(key);
    
    calcNextDialogue(String.valueOf(key));
 
  }
  
  catch(Exception e)  {System.out.println("ERROR");}
}
