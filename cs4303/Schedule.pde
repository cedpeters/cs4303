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
    for(Event event : possibleEvents) {
      
      System.out.println("EVENT: " + event.location);
            
      boolean foundOne = true;
      
      //Loop through possible columns
      for(int i = 0; i < timeSlots.length; i++) {
        System.out.println("COLUMN: " + i);
        for(int j = event.startTime - startTime; j < event.endTime - startTime; j++) {
          System.out.println("TIME: " + (j + startTime));
          if(timeSlots[i][j] == 1) {
           System.out.println("ALREADY FULL");
           foundOne = false;
           break;
          }
        }
        if(foundOne) {
          System.out.println("FOUND ONE!");
          for(int j = event.startTime - startTime; j < event.endTime - startTime; j++) {
            timeSlots[i][j] = 1;
          }
          
          fill(color(100,100,100));
          
          rect(position.x + (width * (i + 1)/4), position.y + ((event.startTime - startTime) * height/(sleepTime-startTime)), width/4, (event.endTime - event.startTime) * height/(sleepTime-startTime));
          
          break;
        }
        else foundOne = true;
      }
      if(!foundOne) System.out.println("ERROR WITH SCHEDULING"); //TODO: DEAL WITH THIS PROPERLY
      foundOne = true;
    }
  }
}
