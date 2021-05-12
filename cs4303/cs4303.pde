

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
  currentDay = 1;
  
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
  calcDialogueOptions();
  
  header.draw();
    
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
         "\nType \'C\' to continue this conversation.";
       }
     }
     
     else if(currentDay == 2) {
       
       if(latestDialogue == null) {
         latestDialogue = "C: Good morning and welcome to your second day in the game. Did you have a good time yesterday?";
         
         latestDialogue += 
          "\n1: No, that was horrible." + 
         "\n2: Yes, I guess."; 
         
         currentView = 1;
       
       }
       
       if(keyPressed == null) {
        dialogueResponseOptions = new String[]{
           "\nThat\'s too bad. I'm afraid you'll need to learn how to appreciate the fine points of a mundane day, if you\'re going to get out of here. Until tomorrow!",
           "\nThat\'s good. Try to hold onto that "
         }; 
       }
       
       else {
         
         int numPressed = Integer.parseInt(keyPressed);
                           
         if(dialogueResponseOptions != null && numPressed > 0 && numPressed <= dialogueResponseOptions.length) {
           latestDialogue += dialogueResponseOptions[numPressed - 1];
           latestDialogue += "\nPress C to continue with your game.";
           currentView = 3;
           dialogueResponseOptions = null;
         }
         else return;
       }
       
       //todo: dorm room day 2, regular dialogue after the first hour.
     }
     
     /**
     TO ADD:
       1. The dialogue for a normal day (can either take a nap, thereby skipping the hour, or can work on the puzzle) - but why would they do that?? Maybe to skip an interaction they don't ned?
       2. The functionality to flip into puzzle mode
       3. "Day 2" conversation (super basic "welcome to day 2!"
       4. "Day 3" conversation (conversation where player is confused, computer explains the rules)
     */
   }
}

void calcDialogueOptions() {
  
  //TODO: DEAL WITH END OF DAY
  
  //If the event has ended and new event options are being displayed
 if(currentView == 3) {
   if(keepOldDialogue == false) latestDialogue = "";
   if(possibleNextEvents.size() != 0) return;
   latestDialogue += "\n\nChoose where you would like to be in the next hour: ";
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

//todo: will delete this, it's not actually part of the game.
void mouseClicked() {
 currentView += 1;
 if(currentView > 3) currentView = 0;
}

void keyReleased() {
  if(key == 'c') calcNextDialogue("C");
  
  try {
    int num = Character.getNumericValue(key);
    
    if(currentView == 1) {
     calcNextDialogue(String.valueOf(key));
     return;
    }
    
    //Make sure that we're in the end of an event, choosing a new one.
    if(currentView == 3 && possibleNextEvents.size() > 0) {
      if(num > possibleNextEvents.size()) return;
      
      advanceToNextEvent(possibleNextEvents.get(num - 1));
      return;
    }
 
  }
  
  catch(Exception e)  {System.out.println("ERROR");}
}
