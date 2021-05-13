class DoingPuzzle extends Block{
    
  Block puzzleStats;
  Block puzzle;
  
  public DoingPuzzle(float x, float y, float width, float height) {
    super(x, y, width, height);
    
    puzzleStats = new Block(x, y, width, height * 0.05);
    puzzle = new Puzzle(x, y + puzzleStats.height, width, height - (puzzleStats.height));
  }
  
 
 public void draw() {
   
   fill(0, 102, 153);
   textAlign(CENTER, CENTER);
    
   puzzleStats.draw("Puzzle Statistics");
   puzzle.draw();
 }
}
