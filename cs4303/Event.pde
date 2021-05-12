class Event {
  String location;
  String description;
  int beginTime;
  int endTime;
  
  public Event(String location, int startTime, int endTime, String description) {
    this.location = location;
    this.description = description;
    this.beginTime = startTime;
    this.endTime = endTime;
  }
  
  public Event() {}
  
  public void calcNextDialogue(String keyPressed) {}
}
