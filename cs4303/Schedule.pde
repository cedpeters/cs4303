class Schedule extends Block {
  public Schedule(float x, float y, float width, float height) {
    super(x, y, width, height);
  }
  
  void draw() {
    super.draw();
    
    ArrayList<Block> entries = new ArrayList();
        
    fill(0, 102, 153);
    textAlign(CENTER, CENTER);
    
    //Print the hours
    for(int n = 0; n <= (sleepTime - startTime); n++) {
     text((n + startTime < 10 ? "0" : "") + (n + startTime) + ":00", position.x + 20, position.y + 10 + (height * n / (sleepTime - startTime + 1))); 
    }
    
    int[][] timeSlots = new int[3][sleepTime - startTime + 1];
    for(Event event : possibleEvents) {
      
      if(event.location.equals("Dorm Room")) { continue; }
                  
      boolean foundOne = true;
      
      //Loop through possible columns
      for(int i = 0; i < timeSlots.length; i++) {
        for(int j = event.beginTime - startTime; j < event.endTime - startTime; j++) {
          if(timeSlots[i][j] == 1) {
           foundOne = false;
           break;
          }
        }
        if(foundOne) {
          for(int j = event.beginTime - startTime; j < event.endTime - startTime; j++) {
            timeSlots[i][j] = 1;
          }
          
          entries.add(new Block(position.x + (width * (i + 1)/4), position.y + ((event.beginTime - startTime) * height/(sleepTime-startTime)), width/4, (event.endTime - event.beginTime) * height/(sleepTime-startTime), event.location));

          break;
        }
        else foundOne = true;
      }
      if(!foundOne) System.out.println("ERROR WITH SCHEDULING"); //TODO: DEAL WITH THIS PROPERLY
      foundOne = true;
    }
    
    for(Block f : entries) f.draw();
  }
}
