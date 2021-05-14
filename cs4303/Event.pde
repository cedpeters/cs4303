class Event {
  
  HashMap<String, int[]> eventNameToTimes = new HashMap();
  HashMap<String, String> eventNameToDescription = new HashMap();
  
  public Event() {
    //Events which are always available
    eventNameToTimes.put("Behavioural Econ (Irvine Building)", new int[]{16,18, 1});
    eventNameToDescription.put("Behavioural Econ (Irvine Building)", "The room is crowded full of students taking notes on all the ways people do not, in fact, behave rationally at all times.");
    
    eventNameToTimes.put("Breakfast (Uni Hall)", new int[]{9, 10, 1});
    eventNameToDescription.put("Breakfast (Uni Hall)", "There\'s nothing like the smell of fried food in the morning. Help yourself to a full plate of haggis, potatoes and bacon and have a seat at your usual table. It looks pretty empty today.");

    eventNameToTimes.put("Career Fayre (The Student Union)", new int[]{14, 17, 1});
    eventNameToDescription.put("Career Fayre (The Student Union)", "The huge Club 601 has been turned into a claustrophobic collection of alleyways, each one lined with the tables belonging to prospective employers. Some students float through the room, grabbing free pens and socks and avoiding the eyes of recruiters. Others dominate the attention of the people in corporate shirts, labouriously pouring a checklist of accomplishments into captive ears.");
    
    eventNameToTimes.put("Career Workshop (Careers Centre)", new int[]{10, 11, 0});
    eventNameToDescription.put("Career Workshop (Careers Centre)", "About twenty people crowd into a small room, perching on couches and standing by them. Before the talk starts, everyone focuses on grabbing as many free pens, pamphlets, and books as they can discreetly shove in their bags. The instructor walks in and pairs you up with your classmate, Miri, to practice sample interview questions.");
    
    eventNameToTimes.put("Dinner (Uni Hall)", new int[]{17, 18, 1});
    eventNameToDescription.put("Dinner (Uni Hall)", "The room is bustling full of friends calling greetings to each other, walking over to say hi, and chattering about their days. The food is less heartwarming.");

    eventNameToTimes.put("Dorm Room", new int[]{startTime, sleepTime-1, 1});
    eventNameToDescription.put("Dorm Room", "Welcome to your dorm room! This is your safe, quiet space. No one will bother you here (besides me, of course - no getting away from the narrator!), but you'll never get out of the game by staying here all day every day, either.");
    
    eventNameToTimes.put("Econometrics Lecture (Upper College Lawn)", new int[]{9, 11, 1});
    eventNameToDescription.put("Econometrics Lecture (Upper College Lawn)", "An interesting choice. Ten minutes of chatting with your friends in exchange for 45 minutes of wondering why anyone would voluntarily subject themselves to statistics courses.");

    eventNameToTimes.put("Economic History (Upper College Lawn)", new int[] {13, 15, 1});
    eventNameToDescription.put("Economic History (Upper College Lawn)", "The only module where listening to \'Hamilton\' counts as background research.");

    eventNameToTimes.put("Economic History Tutorial (Castlecliffe)", new int[]{18, 19, 1});
    eventNameToDescription.put("Economic History Tutorial (Castlecliffe)", "You\'re in a beautiful building next to the sea, though there\'s no window in this tutorial room. You nab a seat by the beautiful bricked up fireplace and listen to a discussion about the cyclical under-regulation of banks.");

    eventNameToTimes.put("JP Morgan Talk (Hotel Du Vin)", new int[]{12, 14, 0});
    eventNameToDescription.put("JP Morgan Talk (Hotel Du Vin", "The fancy room is full of people in suits and nice dresses. There are beautiful vases of flowers on tables in the corners of the room. Looking more closely, you can see the streaks of sweat on the faces of older students, the wide smiles on their faces when they talk to recruiters a bit too constant to be genuine. When you sit down, Miri - her own smile plastered on - sits next to you.");

    eventNameToTimes.put("Lunch (Uni Hall)", new int[] {13, 14, 1});
    eventNameToDescription.put("Lunch (Uni Hall)", "Today\'s lunch options are pizza, baked potato or macaroni & cheese with a side of chips, garlic bread, and peas. Yum.");
    
  }
  
  
  public void calcNextDialogue(String keyPressed) {
    
    if(keyPressed == null && latestDialogue != null) return;
    
    switch(currentLoc) {
      case "Breakfast (Uni Hall)":
        calcNextDialogueBreakfast(keyPressed);
        break;
      case "Career Fayre (The Student Union)":
        calcNextDialogueCareerFayre(keyPressed);
        break;
      case "Career Workshop (Careers Centre)":
        calcNextDialogueCareerWorkshop(keyPressed);
        break;
      case "Dorm Room":
        calcNextDialogueDormRoom(keyPressed);
        break;
      case "Dinner (Uni Hall)":
        calcNextDialogueDinner(keyPressed);
        break;
      case "Econometrics Lecture (Upper College Lawn)":
        calcNextDialogueEconometrics(keyPressed);
        break;
      case "Economic History (Upper College Lawn)":
        calcNextDialoguEconHistory(keyPressed);
        break;
      case "JP Morgan Talk (Hotel Du Vin)":
        calcNextDialogueJPMorgan(keyPressed);
        break;
      case "Lunch (Uni Hall)":
        calcNextDialogueLunch(keyPressed);
        break;
      default: 
        changeView(3); //move to the next hour
    }
  }
  
  public String getFirstLocOfDay() {
   return "Dorm Room"; 
  }
  
  public String getDescription(String e) {
   return eventNameToDescription.get(e); 
  }
  
  public int endTimeOf(String e) {
    if(e.equals("Dorm Room")) return currentTime + 1;
    return eventNameToTimes.get(e)[1]; 
  }
  
  
  //TODO: make the *new event: etc* notifications only show the first time you learn about them!
  
  //************************Breakfast*****************************
  private void calcNextDialogueBreakfast(String keyPressed) {
    
    if(latestDialogue == null) {
      latestDialogue = "*Stefan plops into his usual seat next to you, brown hair tousled and eyes still a bit glazed with sleep.*"
      + "\nStefan: 'Morning"
      + "\nEnya: Good morning, Stefan. You look tired. Were you out late last night?"
      + "\nStefan: No, I just stayed up too late watching YouTube as usual. Then I got butt-dialed right when I was getting in bed."
      + "\nEnya: Yikes, really? Who was it?"
      + "\nStefan: It was Peter. Dunno why I ever signed up to mentor a first-year in my fourth year, he's such a pain. He was on a night out, super wasted, babbling about how much his missed his sister of all things."
      + "\nEnya: Aw, I'm sorry about that.";
      
      //I know that Peter misses his sister
      people.namesToStats.get("Peter")[3] = 1;
      
      //Increment times seen today
      people.namesToStats.get("Peter")[1]++;
      
      //If I know his favourite singer, add the option to discuss that.
      if(people.namesToStats.get("Stefan")[2] == 1) {
        latestDialogue += 
          "\n\n1: At least Peter's drunk voice is still a better sound than AJR, right?" + 
          "\n2: I lost my AJR CD, is there any way I could borrow yours?" + 
          "\n3: Goodbye, Stefan";
          
          //keepOldDialogue = false;
          
        dialogueResponseOptions = new String[]{
           "\nStefan: Excuse me, what?" + 
           "\nEnya: Yeah, I mean, I haven\'t listened to a lot of AJR but it doesn't seem that good." + 
           "\nStefan: You obviously have no idea what you're talking about. Hmm. If you'll be really careful, I can lend you my favourite CD of theirs. It's signed." + 
           "\nEnya: Yes, I'll be very careful. Thank you." + 
           "\n*Puzzle Acquired*",
           "Stefan: Oh, uh, I don't know. It's signed, I don't really lend it out." + 
           "Enya: Are you sure? I really want to listen to it." + 
           "Stefan: Yeah, sorry." + 
           "Enya: Ugh, okay.",
           "\nStefan: Goodbye, Enya."
        };
      }
      
      //I don't know his favourite singer, so just end the conversation.
      else {
       changeView(3); 
      }
    }
    
    //Conversation is already in progress. 
    //By filtering process, a key must have been pressed.
    //This is also never the response for advancing to a new location.
    else {
      int numPressed = Integer.parseInt(keyPressed);
                           
      if(dialogueResponseOptions != null && numPressed > 0 && numPressed <= dialogueResponseOptions.length) {
        latestDialogue += dialogueResponseOptions[numPressed - 1];
        changeView(3);
        dialogueResponseOptions = null;
        if(numPressed - 1 == 0) {
         gatheredPuzzles.add(new Puzzle("Stefan" ));
         people.namesToStats.get("Stefan")[0] = 1; //record that we've received his puzzle
        }
      }
    }
  }
  
 //************************Career Fayre*****************************
  private void calcNextDialogueCareerFayre(String keyPressed) {
    
    if(latestDialogue == null) {
      latestDialogue = "*Choose whether you'd like to talk to (1) Peter or (2) Miri. *";
      
      dialogueResponseOptions = new String[] {
        "\n* You find Peter belly-up to the Amazon booth, grabbing a portable charger and awkwardly nodding at the recruiter who seems to have decided not to attempt her spiel. * ",
        "\n* You find Miri in deep conversation with a Suisse representative about the various graduate routes they offer. After ten minutes, you manage to catch her attention as she's moving to the next booth. *"
      };
    }
    
    //Conversation is already in progress. 
    //By filtering process, a key must have been pressed.
    //This is also never the response for advancing to a new location.
    else {
      int numPressed = Integer.parseInt(keyPressed);
                           
      if(dialogueResponseOptions != null && numPressed > 0 && numPressed <= dialogueResponseOptions.length) {
        latestDialogue += dialogueResponseOptions[numPressed - 1];
        dialogueResponseOptions = null;
        
        if(numPressed - 1 == 0) {
            people.namesToStats.get("Peter")[1]++; //increment times seen today
            latestDialogue += "\nPeter: Oh, hi, Enya. Look at all this stuff I've got! I'll never have to buy pens again." + 
            "\nEnya: Wow, you've definitely got a lot of bags and pens. Have you learned about any interesting options for the future?" + 
            "\nPeter: *grimaces* I don't know, that's a long ways away. It all seems very stressful, I mean look at some of these people. It's like they're bargaining for their life." + 
            "\n* New fact learned about Peter: he hates thinking about the future* " + 
            "\n Enya: Well, I'm glad the stuff is worth it even if the companies aren't very exciting." + 
            "\nPeter: Yeah. Though I might try to give back these massive books they gave me when I came in, full of employers. If I'd wanted a weighty lecture on getting a job, I would have gone to that careers centre talk earlier." +
            "\nEnya: Wait, what talk?" +
            "\nPeter: At 10, there was a workshop at the careers centre. It sounds pretty boring, not going to lie." + 
            "\nEnya: to be fair, you're just a first-year. You might find all of this a bit less mind-numbing in a couple years." +
            "\nPeter: *pulls a face* Maybe." + 
            "\n* New event discovered: 10 careers workshop. It will appear on your schedule tomorrow. *";
            
            people.namesToStats.get("Peter")[2]++; //We know Peter hates thinking about the future
            
            eventNameToTimes.get("Career Workshop (Careers Centre)")[2] = 1; //We know about the careers workshop
            
            changeView(3);
            
        }
        else if(numPressed - 1 == 1) {
          
            people.namesToStats.get("Miri")[1]++; //increment times seen today 
            
            if(people.namesToStats.get("Miri")[1] == 1) {
              //first time seeing her today
              latestDialogue += "\nMiri: Hi, you're Enya, right? I can't talk right now, I'm busy.";
              changeView(3);
            }
            
            else if(people.namesToStats.get("Miri")[1] > 2) {
             //Seen her too many times
               latestDialogue += "\nMiri: No offense, but I've already talked to you a lot today. I need to network with more people now.";
               changeView(3);
            }
            
            else {
             //Seen her exactly once
             latestDialogue += "\nMiri: Oh, hi again, Enya! It's a small world, haha. ";
             
             if(people.namesToStats.get("Miri")[2] == 1 && people.namesToStats.get("Miri")[3] == 0 && people.namesToStats.get("Miri")[4] == 1) { 
               //I know about Agatha Christie, she didn't tell me about Agatha Christie today, and I know about her parental stress
              //TODO: add these as separate dialogue trees when have more time.
                latestDialogue += "*You tell Miri about your parents being stressful, and about how much you love Agatha Christie novels, and she lends you her laptop. Puzzle acquired!";
                gatheredPuzzles.add(new Puzzle("Miri"));
                people.namesToStats.get("Miri")[0] = 1; //record that we've received her puzzle
                changeView(3);
             }
            }
        }
      }
    }
  }
  
    //************************Career Workshop*****************************
  private void calcNextDialogueCareerWorkshop(String keyPressed) {
    
    if(latestDialogue == null) {
      latestDialogue = "Miri: Here, you interview me. I really need the practice, I'm hoping to get a couple interviews soon." + 
      "\nEnya: Sure. Um, let's see. What is a problem you have faced while working on a team project, and how did you move past it?" + 
      "\n*Miri blinks, stares into space for a minute, then begins talking with uncanny smoothness*" + 
      "\nMiri: An example of a problem I have faced on a team project occurred last semester. I was doing a consulting project with Playfair, and our slides were not well-organised." + 
      " I took on the challenge of coordinating everyone's work and polishing all of our slides, and we wound up with a strong presentation for our clients. The end result was positive feedback on our project." + 
      "\nEnya: Um, okay. For the next one, try to sound a bit less rehearsed maybe? Next question: \"Describe a time when you faced conflicting deadlines. How did you cope with them?\"" + 
      "\nMiri: I never know how to answer these. The truth is that I always try to schedule everything in advance but then I wind up scrabbling at the last minute and getting incredibly stressed out." + 
      "\nEnya: Yeah that doesn't sound great. For me, sometimes it can be helpful to take a break when the deadlines get too overwhelming." + 
      "\nMiri: Sometimes I do that, I'll take a couple hours off and read an Agatha Christie murder mystery. But usually I don't have time. Anyway, as for my official answer, I don't have one yet but I'll make a note to come up with something. " + 
      "Maybe I'll say that I finish one deadline a week early." + 
      "\n* You know a new fact about Miri: she loves Agatha Christie novels. *";
      
      //I know that Miri likes Agatha Christies
      people.namesToStats.get("Miri")[2] = 1;
      
      //Increment number of times seen today
      people.namesToStats.get("Miri")[1]++;
      
      //She told me about Agatha Christie today
      people.namesToStats.get("Miri")[3] = 1;
      
      //TODO: MUST ADD A WAY TO PREVENT MIRI FROM MENTIONING AGATHA CHRISTIE
      
      //Move on to next location.
      changeView(3);
    }
  }
  
  
  //*************************Dinner********************************
  private void calcNextDialogueDinner(String keyPressed) {
    changeView(3);
  }
  
  //*************************Dorm Room*****************************
  private void calcNextDialogueDormRoom(String keyPressed) {
     if(currentDay == 1) firstDayDorm(keyPressed);
     
     else if(currentDay == 2 && currentTime == startTime) secondDayMorning(keyPressed); 
     
     else regularDayDorm(keyPressed);
     
     //Todo: add the dialogue for after solving the final puzzle (i.e. winning!)
     
     //todo: else regularDay(keyPressed); - can take a nap or work on puzzle
     
     //todo: currentDay == 3 (explain the rules of the game)
  }
  
    private void firstDayDorm(String keyPressed) {
    
    //Dialogue when you arrive to the location
    if(latestDialogue == null) {
      
      //The very first dialogue of the game
      if(currentTime == 8) {
        latestDialogue = "C: Good morning, Enya. Welcome to your new life." +
         "\nE: Wh-where am I? What's going on?" + 
         "\nC: You're in St Andrews. It's Friday of week 4 and you're in your first day here out of many." + 
         "\nType \'C\' to continue this conversation.";
      }
      
      //The dialogue that greets you on subsequent visits to the location
      else {
       latestDialogue = "C: Welcome back to your dorm room. I\'m afraid there\'s not much to do here, today.";
       currentView = 3;
      }
    }
    
    //Subsequent Dialogue
    else {
      
      //If key has been pressed, deal with it.
      if(keyPressed.equals("C")) {
        latestDialogue = "C: At the end of each hour you will be offered the chance to attend any event currently happening on your calendar. " + 
       "\nType the letter next to the event you wish to attend and you will be transported there." + 
       "\nP: What is my goal here? How do I win the game?" + 
       "\nC: Today is meant for exploring. I will explain the details tomorrow morning.";
       currentView = 3;
       keepOldDialogue = true;
      }
    }
  }
  
  private void secondDayMorning(String keyPressed) {
        
    //Start of the location
    if(latestDialogue == null) {
         latestDialogue = "C: Good morning and welcome to your second day in the game. Did you have a good time yesterday?"
         +"\n1: No, that was horrible." + 
         "\n2: Yes, I guess."; 
         
         dialogueResponseOptions = new String[]{
           "\nThat\'s too bad. I'm afraid you'll need to learn how to appreciate the fine points of a mundane day" + 
           "\nin order to get out of here.",
           "\nThat\'s good. Try to hold onto that."
         };
         
         String explanation = " In order to get out of the game, you need to solve three puzzles. Convince three people to lend you a prized possession, then bring those items here to solve the puzzle attached to each one. You will lose your puzzle pieces at the end of each day.";
         
         dialogueResponseOptions[0] += explanation;
         dialogueResponseOptions[1] += explanation;
    }
    
    else {
      int numPressed = Integer.parseInt(keyPressed);
                           
      if(dialogueResponseOptions != null && numPressed > 0 && numPressed <= dialogueResponseOptions.length) {
        latestDialogue += dialogueResponseOptions[numPressed - 1];
        changeView(3);
        dialogueResponseOptions = null;
      }
    }
  }
  
  private void regularDayDorm(String keyPressed) {
    if(gatheredPuzzles.size() == 0) {
      latestDialogue = "C: Welcome back to your dorm room. I\'m afraid there\'s not much to do here right now. Go find some prized items.";
      changeView(3);
    }
    
    else {
      //todo: if all puzzles are solved, just give a stats update. Otherwise, give stats update and provide option to solve a puzzle or move to next event.
    }
  }
  
    //************************Econometrics*****************************
  private void calcNextDialogueEconometrics(String keyPressed) {
    
    if(latestDialogue == null) {
      latestDialogue = "It turns out you're the only person in your friend group who made it to class today. No one to talk to, but you do get to learn about instrumental variables for two hours.";

      //Move on to next location.
      changeView(3);
    }
  }
  
  //************************Economic History*****************************
  private void calcNextDialoguEconHistory(String keyPressed) {
    
    if(latestDialogue == null) {
      latestDialogue = "Stefan: Hi, Enya." + 
      "\nEnya: Hey, Stefan. How's it going?" + 
      "\nStefan: Fine. Pretty chill. I have a couple deadlines next week, but since I already have a job lined up my motivation is pretty down." + 
      "\nEnya: That's so nice, it must take a lot of the stress out of your final semester." + 
      "\nStefan: Definitely. I can't wait to move to London this summer! And I'm so glad I'm done with all those recruitment events. I heard JP Morgan did an event at Hotel Du Vin at noon today, but I'm already going to be working for Deutsche so I didn't bother going." + 
      "\n* New event discovered: JP Morgan Talk. It will appear on your schedule tomorrow. *";
      
      //Increment times seen today
      people.namesToStats.get("Peter")[1]++;
      
      //Now know about JP Morgan talk
      eventNameToTimes.get("JP Morgan Talk (Hotel Du Vin)")[2] = 1;
      
      //If I know he likes dogs, add the option to discuss that.
      if(people.namesToStats.get("Stefan")[1] == 1) {
        latestDialogue += 
          "\n\n1: Personally, I can't wait to move out after graduation next year so I can get a dog! I want a little fluffy one, maybe a Pomeranian." + 
          "\n2: Looks like the lecture is starting, we'd better stop talking.";
          
          //keepOldDialogue = false;
          
        dialogueResponseOptions = new String[]{
           "\nStefan: Ooh yeah, me took! My favourite band, AJR, tweeted \"Everyone should have a dog in their life\" and I definitely agree. " + 
           "I've been stalking all the rescue websites I can find. But I want a really big dog, like a Dobermann. Or a German Shepherd." + 
           "\n * New fact about Stefan: his favourite band is AJR. *",
           "\nStefan: Oh, yeah."
        };
      }
      
      //I don't know his favourite singer, so just end the conversation.
      else {
       changeView(3); 
      }
    }
    
    //Conversation is already in progress. 
    //By filtering process, a key must have been pressed.
    //This is also never the response for advancing to a new location.
    else {
      int numPressed = Integer.parseInt(keyPressed);
                           
      if(dialogueResponseOptions != null && numPressed > 0 && numPressed <= dialogueResponseOptions.length) {
        latestDialogue += dialogueResponseOptions[numPressed - 1];
        changeView(3);
        dialogueResponseOptions = null;
        if(numPressed - 1 == 0) {
         people.namesToStats.get("Stefan")[2] = 1; //record that we know his favourite singer
        }
      }
    }
  }
  
  //************************JP Morgan Talk*****************************
  private void calcNextDialogueJPMorgan(String keyPressed) {
    
    if(latestDialogue == null) {
      //todo: optional, have her remember whether you saw her earlier today.
      latestDialogue = "Miri: Oh you're here, too. Good, I'm not the only one skipping the Economic History lecture today.";
      
      if(people.namesToStats.get("Miri")[1] > 0) latestDialogue += " This should be more interesting than that careers centre event we went to earlier. ";
      
      latestDialogue += "\nEnya: Oh, right, yeah. It's too bad these events overlap." + 
      "\nMiri: Yeah, especially since Mr. De Sousa uses the Socratic method so there aren't any slides to summarize what we're missing. I wish he did give out slides, I'm not great at taking notes in real-time. My mark on the class test makes that clear enough." + 
      "\nEnya: Maybe you can get notes off one of our classmates and study them later." + 
      "\nMiri: Yeah, maybe Stefan will give me his. I'll just have to text him early, because he'll be at that Disney pub quiz at the Adamson from 4pm." + 
      "\n* You have gained a new event: Disney pub quiz. It will be on your schedule starting tomorrow. *";
      
      //TODO: I NOW KNOW ABOUT THE PUB QUIZ!!
      
      //Increment number of times seen today
      people.namesToStats.get("Miri")[1]++;
      
      //Move on to next location.
      changeView(3);
    }
  }
  
  //************************Lunch*****************************
  private void calcNextDialogueLunch(String keyPressed) {
    
    if(latestDialogue == null) {
      latestDialogue = "* Peter wanders up to Enya's table and sits down *" + 
      "\nEnya: You okay?" + 
      "\nPeter: Yup. Just a bit hungover still. Went on a bender last night and it's really hitting me today." + 
      "\nEnya: Yikes, I hope you're taking it easy for the rest of the day." + 
      "\nPeter: *groans* No, my friend Sam's birthday party is tonight. I'm supposed to bring booze and friends. I'm too tired to find either. Hey, Enya, if you want to come it's on Lamond drive starting at six tonight." + 
      "\nEnya: Thanks, Peter. I'm not sure if I'll make it, but I appreciate the offer." + 
      "\n* New event: you have discovered a house party which will be on your calendar starting tomorrow. *";
      
      //Increment number of times seen today
      people.namesToStats.get("Peter")[1]++;
      
      //New event discovered
      //TODO: ADD THAT NOW KNOW HOUSE PARTY
            
      //Move on to next location.
      changeView(3);
    }
  }
  
}

/*

class EventHouseParty extends Event{

  public EventHouseParty() {
    
    super(
      "House Party (The Badlands)", 
      18, 
      22, 
      "You're sticky and you have a headache, but hey - they're playing your favourite song!"
    );
  }
  
  public void calcNextDialogue(String keyPressed) {
     currentView = 3; //Ready to move to next hour
  }
}

class EventDiplomat extends Event{

  public EventDiplomat() {
    
    super(
      "US Diplomat Talk (Medical Building)", 
      9, 
      10, 
      "The environment is uncomfortably stuffy, and everyone seems to be dressed nicer than you."
    );
  }
  
  public void calcNextDialogue(String keyPressed) {
     currentView = 3; //Ready to move to next hour
  }
  
}
*/
