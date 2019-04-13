--[[
This is the list of all possible interactions with NPCs. (this inclues the companion)
Interactions have a specific structure, and messing with that might crash the game.

Each interaction can optionally include any of the following requirements, which limit 
what NPCs can use any particular interaction. For example, an interaction which specifies 
reqAge = {min=20,max=30},
will prevent this interaction by being used by any NPC who's age lies outside of that range

Possible Requirements:

> Range: these requirements check if that npc attribute lies within the given range, inclusive
  - reqMood
  - reqReceptiveness
  - reqFlirtatiousness
  - reqAge
> List: these requirements check if that npc attribute is contained within the given table
  - reqGender
  - reqRelationship
  - reqType
> Single value: these requirements check if that npc attribute is equal to the given value
  - reqContacted

Text in the interactions can make use of the following string substitutions from the npc attributes
{playerName} is replaced with the player's name
{name} is replaced with the NPC's name
{age} is replaced with the NPC's age

Each element of the dialogue array is a different conversation state. Each state should specify
isPlayerText: whether this is the player speaking, or not.
text: the text to display
next: the index of the next state. if nil, will end the conversation instead of proceeding to a new state

text and next are not required if specifying an options state, in which case the state should specify
the options field which is a table with the following fields
optionText: the text for the option
next: the state the option goes to


--]]
return {
  {
    --reqAge = {min=10,max=30},
    dialogue = {
      [1] = {
        isPlayerText = true,
        text = "Hey you!",
        next = 10,
      },
      [2] = {
        isPlayerText = true,
        text = "My name is {playerName}. What's your name?",
        next = 6,
      },
      [3] = {
        isPlayerText = true,
        text = "Did you fall into a sewr? You smell *really* bad.",
        next = 7,
        effects = {
          maxObedience = -30,
        },
      },
      [4] = {
        isPlayerText = true,
        text = "Have you heard of the Book of Mormon before? It's a really great book.",
        next = 8,
        effects = {
          obedience = 25,
        },
      },
      [5] = {
        isPlayerText = true,
        text = "See my companion over there? He's being a total jerk. Help me.",
        next = 7,
      },
      [6] = {
        isPlayerText = false,
        text = "I'm {name}. Nice to meet you. What can I do for you?",
        next = 9,
      },
      [7] = {
        isPlayerText = false,
        text = "Wow. I thought missionaries were supposed to be kind. Get lost.",
      },
      [8] = {
        isPlayerText = false,
        text = "No I have not. It sounds interesting though. Tell me more!",
        effects = {
          contacts = 1
        }
      },
      [9] = {
        isPlayerText = true,
        text = "Well...",
        next = 11,
      },
      [10] = {
        isPlayerText = true,
        options = {
          {
            optionText = "What's your name?",
            next = 2,
          },
          {
            optionText = "You smell funny!",
            next = 3,
          },
          {
            optionText = "Ask about the Book of Mormon.",
            next = 4,
          },
        },
      },
      [11] = {
        isPlayerText = true,
        options = {
          {
            optionText = "Complain about your companion",
            next = 5,
          },
          {
            optionText = "Ask about the Book of Mormon",
            next = 4,
          },
        },
      },
    },
  },
  --[[{
    reqRelationship = {"single","divorced"},
    reqAge = {min=10,max=30},
    reqContacted = false,
    reqType = {"NPC"},
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
    reqFlirtatiousness = {min=75,max=100},
    reqAge = {min=18,max=22},
    reqContacted = false,
    reqType = {"NPC"},
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
  {
    reqRelationship = {"single","divorced","married","dating","widowed","engaged"},
    reqAge = {min=30,max=100},
    reqContacted = false,
    reqType = {"NPC"},
    dialogue = {
      playerText = "Hi, I'm a missiona...",
      npcText = "I know who you are. I used to be a missionary like you.\nThen I took a gunshot to the knee.",
      options = {
        {
          optionText="I'm sorry...",
          playerText="Wow. That sounds rough. Sorry to hear that, I guess...",
          npcText="That's alright. Dang kids nowadays!",
          effect = {
            contacts=1,
            obediometer=0
          }
        },
        {
          optionText="Suck it up!",
          playerText="Look man. Nobody cares about your knee!\nDo you wanna hear the word of God or not?",
          npcText="Get out of my face! Dang kids nowadays!",
          effect = {
            contacts=0,
            obediometer=-50
          }
        },
        {
          optionText="(Start giving a blessing right here)",
          playerText="*Begins praying*",
          npcText="Hey! What are you doing? Dang kids nowadays!",
          effect = {
            contacts=0,
            obediometer=0
          }
        }
      }
    }
  },
  {
    reqRelationship = {"single","divorced","married","dating","widowed","engaged"},
    reqAge = {min=0,max=10},
    reqContacted = false,
    reqType = {"NPC"},
    dialogue = {
      playerText = "Hey there buddy! I'm a missiona...",
      npcText = "Mommy says I shouldn't talk to strangers.",
    }
  },
  {
    reqContacted = false,
    reqType = {"CompanionEntity"},
    dialogue = {
      playerText = "Hello",
      npcText = "({name} is ignoring you)",
    }
  },
  {
    reqContacted = false,
    reqType = {"NPC"},
    dialogue = {
      playerText = "Hello",
      npcText = "I'm not interested.",
    }
  },
  {
    reqContacted = true,
    reqType = {"NPC"},
    dialogue = {
      playerText = "Hey...",
      npcText = "I've got to get going. ",
    }
  },
  {
    reqContacted = false,
    reqType = {"NPC"},
    reqFlirtatiousness = {min=25, max=100},
    reqGender = {"female"},
    reqRelationship = {"single", "widowed", "divorced"},
    reqAge = {min=18, max=26},
    dialogue = {
      playerText = "Hey there!",
      npcText = "Oh hey there, handsome! What's a good-looking guy like you doing?",
      options = {
        {
          optionText = "Flirt with her",
          playerText = "(You flirt with {name})",
          npcText = "(Giggles) I like you... come visit me later, okay?",
          effect = {
            contacts = 0,
            obediometer = -15,
          }
        },
        {
          optionText = "Leave her behind",
          playerText = "Not much. Sorry, I gotta go.",
          npcText = "Oh... okay...",
          effect = {
            contacts = 0,
            obediometer = 10,
          }
        },
        {
          optionText = "Preach some",
          playerText = "I'm here as a missionary.",
          npcText = "Oh really? That's interesting! I'd like to hear more!",
          effect = {
            contacts = 1,
            obediometer = 0,
          }
        }
      }
    }
  },
  {
    reqContacted = false,
    reqType = {"NPC"},
    reqReceptiveness = {min=50, max=100},
    dialogue = {
      playerText = "Hello! Do you have a moment?",
      npcText = "Yeah, I've got time.",
      options = {
        {
          optionText = "Teach about the Book of Mormon",
          playerText = "You begin teaching them about the Book of Mormon...",
          npcText = "That's really interesting. Would you mind teaching me more later?",
          effect = {
            contacts = 1,
            obediometer = 0
          }
        },
        {
          optionText = "Inquire about religion",
          playerText = "Are you religious?",
          npcText = "Not really, and I'm not sure I'm interested.",
          effect = {
            contacts = 0,
            obediometer = 0,
          }
        },
      }
    }
  }--]]
}