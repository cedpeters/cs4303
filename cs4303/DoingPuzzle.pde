class DoingPuzzle extends Block{
    
  Block puzzleStats;
  Block puzzle;
  Block instructions;
  
  public DoingPuzzle(float x, float y, float width, float height) {
    super(x, y, width, height);
    
    puzzleStats = new Block(x, y, width, height * 0.05);
    puzzle = new Block(x, y + puzzleStats.height, width * 0.8, height - (puzzleStats.height));
    instructions = new Block(x + puzzle.width, y + puzzleStats.height, width - puzzle.width, height - (puzzleStats.height), "Use the arrow keys to put the numbers in order. 1 goes in the top left. The empty space should be in the bottom right.");
  }
  
 
 public void draw() {
   
   fill(0, 102, 153);
   textAlign(CENTER, CENTER);
    
   puzzleStats.draw("Puzzle from " + currentPuzzle.name);
   currentPuzzle.draw(puzzle);
 }
}
