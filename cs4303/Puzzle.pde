class Puzzle {
  String name;
  boolean solved;
  
 public Puzzle(String name) {
   this.name = name;
   this.solved = false;
 }
 
 public void draw() {
   System.out.println("DRAW PUZZLE");
   endOfPuzzle();
 }
 
 private void endOfPuzzle() {
  changeView(3);
  latestDialogue = "";
  currentPuzzle = null;
 }
}
