//Blocks on the screen
ArrayList<Block> bodyBlocks;
Header header;
Block body;
float portionHeader = 0.1;

PFont smallFont;
PFont bigFont;

Puzzle currentPuzzle;

//Game status //<>//
String[] possibleViews = {"LocStart", "InConvo", "DoingPuzzle"};

String[] dialogueResponseOptions;

ArrayList<String> possibleNextEvents;

ArrayList<Block> scheduleEntries; //.: reset to null when changing day

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
  
  smallFont = createFont("arial", 12);
  bigFont = createFont("arial", 18);
  textFont(bigFont);
  
  startTime = 8;
  sleepTime = 22; //<>//
  currentTime = startTime;
  currentView = 0;
  keepOldDialogue = true;
  currentDay = 1;
  gatheredPuzzles = new ArrayList(); 
      
  events = new Event();
  people = new People();
  
    
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
  bodyBlocks.add(locStart);
  
}

void draw() {
      
  //Normal (dialogue) view
  if(currentView != 2) {
  
    calcNextDialogue(null);
    
    header.draw();
    
    bodyBlocks.get(currentView).draw();
  }
  
  //puzzle view
  else {
    
    if(currentPuzzle == null) changeView(3);
    
    bodyBlocks.get(currentView).draw();
  }
    
}

void calcNextDialogue(String keyPressed) {
  
  //End of an event: choose next location
 if(currentView == 3) {
    
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
              
       latestDialogue += "\n\nChoose where you would like to be start at time " + newStartTime + ":00:"; 
       
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
 this.currentView = view;
}

void keyReleased() {
  
  if(currentView == 2 && currentPuzzle != null) {
    if(key == CODED) {
     if(keyCode == UP) currentPuzzle.makeMove(false, false);
     else if(keyCode == DOWN) currentPuzzle.makeMove(false, true);
     else if(keyCode == LEFT) currentPuzzle.makeMove(true, true);
     else if(keyCode == RIGHT) currentPuzzle.makeMove(true, false);
    }
    return;
  }
  if(key == 'c') calcNextDialogue("C");
  
  if(key == 'k') cheatAllKnowledgeToTrue();
  
  else calcNextDialogue(key + "");
}

void cheatAllKnowledgeToTrue() {
  events.cheatAllKnowledgeToTrue();
  people.cheatAllKnowledgeToTrue();
  scheduleEntries = null; //force reset the calendar
}
