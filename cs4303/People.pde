class People {
  HashMap<String, int[]> namesToStats = new HashMap(); 
  
  public People() {
   namesToStats.put("Peter", new int[]{0, 0, 0, 0}); //array for Peter: [puzzleGiven, timesSeenToday, iKnowHeHatesFuture, iKnowHeHasSister]
   namesToStats.put("Miri", new int[]{0, 0, 0, 0, 0}); //array for Miri: [puzzleGiven, timesSeenToday, iKnowAgathaChristie, toldMeAgathaChristieToday, iKnowParentsStress]
   namesToStats.put("Stefan", new int[]{0, 0,0}); //array for Stefan: [puzzleGiven, iKnowHeLikesDogs, iKnowHisFavouriteSinger]
  }
}
