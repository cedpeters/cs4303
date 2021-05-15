class People {
  HashMap<String, int[]> namesToStats = new HashMap(); 
  
  public People() {
   namesToStats.put("Peter", new int[]{0, 0, 0, 0}); //array for Peter: [puzzleGiven, timesSeenToday, iKnowHeHatesFuture, iKnowHeHasSister]
   namesToStats.put("Miri", new int[]{0, 0, 0, 0, 0}); //array for Miri: [puzzleGiven, timesSeenToday, iKnowAgathaChristie, toldMeAgathaChristieToday, iKnowParentsStress]
   namesToStats.put("Stefan", new int[]{0, 0, 0}); //array for Stefan: [puzzleGiven, iKnowHeLikesDogs, iKnowHisFavouriteSinger]
  }
  
  public void resetPeopleMemories() {
   int[] peter = namesToStats.get("Peter"); 
   peter[0] = 0;
   peter[1] = 0;
   
   int[] miri = namesToStats.get("Miri");
   miri[0] = 0;
   miri[1] = 0;
   miri[3] = 0;
   
   int[] stefan = namesToStats.get("Stefan");
   stefan[0] = 0;
  }
}
