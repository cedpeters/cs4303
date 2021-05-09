class Schedule extends Block {
  public Schedule(float x, float y, float width, float height) {
    super(x, y, width, height);
  }
  
  void draw() {
    super.draw();
        
    fill(0, 102, 153);
    textAlign(CENTER, CENTER);
    
    //Print the hours
    for(int n = 0; n <= (sleepTime - startTime); n++) {
     text((n + startTime < 10 ? "0" : "") + (n + startTime) + ":00", position.x + 20, position.y + 10 + (height * n / (sleepTime - startTime + 1))); 
    }
    
    int[][] timeSlots = new int[3][sleepTime - startTime + 1];
    System.out.println("LENGTH OF FIRST: " + timeSlots.length);
    System.out.println("LENGTH OF SECOND: " + timeSlots[0].length);
    for(Event event : possibleEvents) {
            
      boolean foundOne = false;
      
      //Loop through possible columns
      for(int i = 0; i < timeSlots.length; i++) {
        for(int j = event.startTime - startTime; j <= event.endTime - startTime; j++) {
          if(timeSlots[i][j] == 1) break;
        }
        if(foundOne) {
          for(int j = event.startTime; j <= event.endTime; j++) {
            timeSlots[i][j] = 1;
          }
          todo this is where I stopped.
          rect(position.x + (width * i/4), position.y, width, height);
          
          break;
        }
      }
      
      if(!foundOne) System.out.println("ERROR WITH SCHEDULING"); //TODO: DEAL WITH THIS PROPERLY
    }
  }
}
