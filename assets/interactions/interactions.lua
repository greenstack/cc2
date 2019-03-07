return {
  {
    reqGender = {"male","female"},
    reqRelationship = {"single","divorced"},
    reqMood = {min=0,max=100},
    reqReceptiveness = {min=0,max=100},
    reqFlirtatiousness = {min=0,max=100},
    reqAge = {min=18,max=26},
    dialogue = {
      playerText = "Hello. Is your name {name}?",
      npcText = "Why yes it is? How did you know?",
      options = {
        {
          optionText="Magic.",
          playerText="Magic can do some amazing things!",
          npcText="Wow that'a amazing. Tell me more!",
          effect = {
            contacts=1,
            obediometer=50
          }
        },
        {
          optionText="Good guess.",
          playerText="I'm a good guesser. I also know that you are {age} years old!",
          npcText="That's kinda creepy...",
          effect = {
            contacts=0,
            obediometer=0
          }
        }, 
        {
          optionText="The Priesthood.",
          playerText="I used the power of the Priesthood to discern your name.",
          npcText="... okay ...",
          effect = {
            contacts=0,
            obediometer=-50
          }
        },
      }
    }
  },
  {
    reqGender = {"female"},
    reqRelationship = {"single","divorced"},
    reqMood = {min=0,max=100},
    reqReceptiveness = {min=0,max=100},
    reqFlirtatiousness = {min=75,max=100},
    reqAge = {min=18,max=22},
    dialogue = {
      playerText = "Hey, how's it going?",
      npcText = "I'm doing great, now that you're around!",
      options = {
        {
          optionText="Ask her out",
          playerText="Let me buy you dinner!",
          npcText="uh... okay yeah sounds fun!",
          effect = {
            contacts=1,
            obediometer=-500
          }
        },
        {
          optionText="Shut her down.",
          playerText="I'm sorry, I'm already in a relationship",
          npcText="I'll see you around I guess...",
          effect = {
            contacts=0,
            obediometer=20
          }
        },
      }
    }
  },
  
}