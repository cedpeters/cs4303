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
    
    //If the schedule has already been created, just print it and be done.
    if(scheduleEntries != null) {
      for(Block f : scheduleEntries) {
        f.draw();
      }
      return;
    }
    
    //Make an empty list of the possibilities for each hour.
    possibleEventsEachHour = new HashMap();
    for(int i = startTime; i < sleepTime; i++) {
     possibleEventsEachHour.put(i, new ArrayList()); 
     possibleEventsEachHour.get(i).add("Dorm Room");
    }
    
    
    int[][] timeSlots = new int[3][sleepTime - startTime + 1];
    scheduleEntries = new ArrayList();
    
    for(HashMap.Entry<String, int[]> event : events.eventNameToTimes.entrySet()) {
      String key = event.getKey();
      int[] value = event.getValue();
      
      if(key.equals("Dorm Room") || value[2] == 0) continue;
      
      possibleEventsEachHour.get(value[0]).add(key);
      
      System.out.println("LOCATION TO BE ADDED: " + key);
      
      boolean foundOne = true;
      
      //Loop through possible columns
      for(int i = 0; i < timeSlots.length; i++) {
        for(int j = value[0] - startTime; j < value[1] - startTime; j++) {
          if(timeSlots[i][j] == 1) {
           foundOne = false;
           break;
          }
        }
        if(foundOne) {
          for(int j = value[0] - startTime; j < value[1] - startTime; j++) {
            timeSlots[i][j] = 1;
          }
          
          scheduleEntries.add(new Block(position.x + (width * (i + 1)/4), position.y + ((value[0] - startTime) * height/(sleepTime-startTime)), width/4, (value[1] - value[0]) * height/(sleepTime-startTime), key));

          break;
        }
        else foundOne = true;
      }
      if(!foundOne) System.out.println("ERROR WITH SCHEDULING"); //TODO: DEAL WITH THIS PROPERLY
      foundOne = true;
    }
    

    for(Block f : scheduleEntries) f.draw();
  }
}
