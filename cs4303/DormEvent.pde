class DormEvent extends Event {
  
  public DormEvent() {
    
    super.location = "Dorm Room";
    super.description = "Welcome to your dorm room! This is your safe, quiet space. No one will bother you here (besides me, of course - no getting away from the narrator!), but you'll never get out by staying here all day every day, either.";
    super.startTime = startTime;
    super.endTime = sleepTime - 1;
  }
  
}
