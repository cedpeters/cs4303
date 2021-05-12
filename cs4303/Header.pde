class Header extends Block{
    
  Block clock;
  Block day;
  Block location;
  
  public Header(float x, float y, float width, float height) {
    
    super(x, y, width, height);
         
    clock = new Block(x, y, width * 0.33, height);
    day = new Block(clock.position.x + clock.width, y, width * 0.33, height);
    location = new Block(day.position.x + day.width, y, width - (clock.width + day.width), height);
  }
 
 public void draw() {
   clock.draw((currentTime < 10 ? "0" : "") + currentTime + ":00");
   day.draw("Day " + currentDay);
   location.draw(currentLoc.location);
 }
}
