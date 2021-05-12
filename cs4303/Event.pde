class Event {
  String location, description;
  int startTime, endTime;
  
  public Event(String location, int startTime, int endTime, String description) {
    this.location = location;
    this.description = description;
    this.startTime = startTime;
    this.endTime = endTime;
  }
  
  public Event() {}
}
