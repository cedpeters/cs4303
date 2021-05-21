import java.util.Random;

class Puzzle {
  String name;
  boolean solved;
  
  PFont numFont = createFont("arial", 24);
  
  int[][] board;
  int[] currentEmpty;
  
 public Puzzle(String name) {
   this.name = name;
   this.solved = false;
   
   generateBoard();
 }
 
 public void draw(Block confines) {
   confines.draw();
   
   float left = confines.position.x + 0.01*confines.width;
   float right = confines.position.x + confines.width - 0.01*confines.width;
   
   float top = confines.position.y + 0.01*confines.height;
   float bottom = confines.position.y + confines.height - 0.01*confines.height;
   
   float numWidth = (right - left) / board.length;
   float numHeight = (bottom - top) / board[0].length;
   
   textAlign(CENTER, CENTER);
   textFont(numFont);
   for(int i = 0; i < board.length; i++) {
    float topOfRow = top + (numHeight * i);
    
    for(int j = 0; j < board[0].length; j++) {
     float leftOfRow = left + (numWidth * j);
     
     fill(color(192, 207, 203));
     rect(leftOfRow, topOfRow, numWidth, numHeight);
     
     fill(0, 102, 153); 
     if(board[i][j] == 0) continue;
     text("" + board[i][j], leftOfRow, topOfRow, numWidth, numHeight);
    }
   }
   textFont(gameFont);
 }
 
 private void generateBoard() {
  Random random = new Random();
  
  this.board = new int[][] {
    {1,2,3,4},
    {5,6,7,8},
    {9,10,11,12},
    {13,14,15,0}
  };
  
  currentEmpty = new int[] {3,3};
  
  //todo: adjust difficulty depending on whose puzzle it is
  for(int i = 0; i < 50; i++) {
    //Decide to change either x or y
    boolean moveX = random.nextBoolean();
    
    //Decide to either increase or decrease
    boolean increase = random.nextBoolean();
    
    int[] newLoc;
    
    if(moveX) {
     if(increase) newLoc = new int[] {currentEmpty[0] + 1, currentEmpty[1]};
     else newLoc = new int[] {currentEmpty[0] - 1, currentEmpty[1]};
    }
    
    else {
      if(increase) newLoc = new int[] {currentEmpty[0], currentEmpty[1] + 1};
      else newLoc = new int[] {currentEmpty[0], currentEmpty[1] - 1};
    }
    
    if(isValidLoc(newLoc)) moveToLoc(newLoc);
  }
 }
 
 private boolean isValidLoc(int[] loc) {
   //Make sure the x is valid
   if(loc[0] < 0 || loc[0] >= board.length) return false;
   
   //Make sure the y is valid
   if(loc[1] < 0 || loc[1] >= board[0].length) return false;
   
   return true;
 }
 
 private void moveToLoc(int[] newLoc) {
   int valAtNewLoc = board[newLoc[0]][newLoc[1]];
   
   board[newLoc[0]][newLoc[1]] = 0;
   
   board[currentEmpty[0]][currentEmpty[1]] = valAtNewLoc;
   
   currentEmpty = newLoc;
   
 }
 
 private void endOfPuzzle() {
  changeView(3);
  latestDialogue = "";
  currentPuzzle = null;
 }
}
