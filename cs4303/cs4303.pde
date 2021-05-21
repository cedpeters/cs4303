//Blocks on the screen
ArrayList<Block> bodyBlocks;
Header header;
Block body;
float portionHeader = 0.1;

PFont gameFont;

//Game status
String[] possibleViews = {"LocStart", "InConvo", "DoingPuzzle", "EventEnd"}; //<>//

String[] dialogueResponseOptions;

ArrayList<String> possibleNextEvents;

ArrayList<Block> scheduleEntries; //TODO: reset to null when changing day

HashMap<Integer, ArrayList<String>> possibleEventsEachHour;

ArrayList<Puzzle> gatheredPuzzles;

String currentLoc;

int startTime;
int sleepTime;
int currentTime;
int currentView;
boolean keepOldDialogue;
int currentDay;

People people;

Event events;

String latestDialogue;

void setup() {
  
  
  fullScreen();
  
  gameFont = createFont("arial", 12);
  textFont(gameFont);
  
  startTime = 8;
  sleepTime = 22;
  currentTime = startTime;
  currentView = 0; //<>//
  keepOldDialogue = true;
  currentDay = 1;
  gatheredPuzzles = new ArrayList();  //todo add when resetting the day
      
  events = new Event();
  people = new People();
  
    
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
    
    int endOfEvent = events.endTimeOf(currentLoc);
    
    if(endOfEvent == sleepTime) {
     if(keyPressed == null) {
      if(!latestDialogue.contains("continue to the next day")) {
       latestDialogue += "\n It is the end of the day. Type C to continue to the next day."; 
      }
     }
     
     else if(keyPressed == "c" || keyPressed == "C") {
      nextDay(); 
     }
     
     return;
    }
    
    //It's time to move on but the player hasn't entered a command yet
    if(keyPressed == null) {
       if(possibleNextEvents != null) return; //If this has already been done, don't recreate the wheel
       
       possibleNextEvents = new ArrayList();
       
       if(keepOldDialogue == false) latestDialogue = "";
       
       int newStartTime = events.endTimeOf(currentLoc);
       
       //TODO: PUT IN CHECK FOR THE END OF THE DAY.
       
       latestDialogue += "\n\nChoose where you would like to be start at time " + newStartTime + ":"; 
       
       for(String e : possibleEventsEachHour.get(newStartTime)) {
         possibleNextEvents.add(e);
         latestDialogue += "\n" + possibleNextEvents.size() + ": " + e;
       }
     }
    
     else {
       try {
         int num = Integer.parseInt(keyPressed);
         
         if(num > possibleNextEvents.size()) return;
        
          advanceToNextEvent(possibleNextEvents.get(num - 1));
       }
       
       catch(Exception e) {
        //do nothing, it's an invalid number. 
       }
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

void nextDay() {
 possibleNextEvents = null;
 currentView = 0;
 currentTime = startTime;
 latestDialogue = null;
 currentLoc = events.getFirstLocOfDay();
 keepOldDialogue = true;
 currentDay ++;
 scheduleEntries = null;
 gatheredPuzzles = new ArrayList();
 
 people.resetPeopleMemories();
}
 

void changeView(int view) {
 if(view == 3) {
  this.currentView = 3;
  //this.currentTime = events.endTimeOf(currentLoc);
 }
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
