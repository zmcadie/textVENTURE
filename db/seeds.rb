# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

State.destroy_all
Game.destroy_all
@game1 = Game.create! name: "Harry Potter Maze", publish: true

@game2 = Game.create! name: "Windows XP Rooms", publish: true

# Game 1 #

@maze_entrance = @game1.states.create! name: "entrance", description: "'Champions, welcome to the third and final task of the Tri-Wizard tournament! In the center of the maze that lies before you, you will find the Tri-Wizard Cup.' You walk towards the entrace of the maze. 'Champions, good luck, and remember you can call for help at any time!' Do you want to enter the maze?"

@game1.initial_state_id = @maze_entrance.id
@game1.save

@enter = @game1.states.create! name: "enter", description: "As you enter the maze, the bushes close behind you, your breathing is the only sound. There's no turning back now. Ahead, the maze forks into two paths leading off to your left and to your right. Where do you want to go?"

@no_enter = @game1.states.create! name: "no_enter", description: "Scared, you turn to run back into the crowd but Mad-eye grabs your shoulder and shoves you into the maze. The bushes close behind you, your breathing is the only sound. There's no turning back now. Ahead, the maze forks into two paths leading off to your left and to your right. Where do you want to go?"

@right = @game1.states.create! name: "right", description: "You turn right and run down the narrow dirt path. Up ahead and to your left, you hear screaming. To your right you see a small puff of smoke."

@left = @game1.states.create! name: "left", description: "You turn left and sprint forward. Tripping over a root your face slams into the ground, breaking your glasses. No matter, 'Repairo!' Hermione has taught you well. Up ahead the path forks again, to your left you hear a low grumbling and to your right the way seems clear."

@smoke = @game1.states.create! name: "smoke", description: "A blast ended skrewt! Ten feet long, it looks more like a giant scorpion than anything. Its long sting is curled over its back. Its thick armor glints in the light from your wand. Darting back behind the corner of the bushes you run through a few spells under your breath... 'Reducto, Stupify, Expelliarmus...' It must have smelled your fear, for it trundles around the corner, both blasters trained menacingly on you. You raise your wand and shout:"

@spells = @game1.states.create! name: "spells", description: "You manage to hit it square in its fleshy, shell-less underside. It flies twenty feet into the air and hits the ground behind you with a sickening crunch. Phew! That was close! Looking around you see the maze leaves you with no option but to go forward."

@cup = @game1.states.create! name: "cup", description: "Ahead you see a slight blue gleam is shimmering. That's it! The Triwizard Cup stands gleaming on a plinth a hundred yards away. You sprint forward and reaching it, hold a hand out over one of it's gleaming handles. Victory is so close. You only need to reach out at grab it."

# Game 2 #

@blue_room = @game2.states.create! name: "blue", description: "You enter a blue room. There are two doors, one to the north and one to the east. Where do you want to go?"

@game2.initial_state_id = @blue_room.id
@game2.save

@red_room = @game2.states.create! name: "red", description: "You enter a red room. There are two doors, one to the south and one to the east. Where do you want to go?"

@green_room = @game2.states.create! name: "green", description: "You enter a green room. There are two doors, one to the south and one to the west. Where do you want to go?"

@yellow_room = @game2.states.create! name: "yellow", description: "You enter a yellow room. There are two doors, one to the north and one to the west. Where do you want to go?"

# Game 1 #

@maze_entrance.actions.create!({
  trigger: 'no',
  description: 'you dont want to enter the maze',
  result_id: @no_enter.id
})

@maze_entrance.actions.create!({
  trigger: 'yes',
  description: 'you do want to enter the maze',
  result_id: @enter.id
})

@enter.actions.create!({
  trigger: 'left',
  description: 'you pick left',
  result_id: @left.id
})

@enter.actions.create!({
  trigger: 'right',
  description: 'you pick the right path',
  result_id: @right.id
})

@no_enter.actions.create!({
  trigger: 'left',
  description: 'you pick left',
  result_id: @left.id
})

@no_enter.actions.create!({
  trigger: 'right',
  description: 'you pick the right path',
  result_id: @right.id
})

@right.actions.create!({
  trigger: 'left',
  description: 'you pick left',
  result_id: @left.id
})

@right.actions.create!({
  trigger: 'screaming',
  description: 'you go towards the screaming',
  result_id: @left.id
})

@right.actions.create!({
  trigger: 'right',
  description: 'you pick the right path',
  result_id: @smoke.id
})

@right.actions.create!({
  trigger: 'smoke',
  description: 'you walk towards the smoke',
  result_id: @smoke.id
})

@left.actions.create!({
  trigger: 'left',
  description: 'you pick left',
  result_id: @smoke.id
})

@left.actions.create!({
  trigger: 'grumbling',
  description: 'you walk towards the grumbling',
  result_id: @smoke.id
})

@left.actions.create!({
  trigger: 'right',
  description: 'you pick the right path',
  result_id: @cup.id
})

@left.actions.create!({
  trigger: 'clear',
  description: 'you walk towards the clear',
  result_id: @cup.id
})

@smoke.actions.create!({
  trigger: 'reducto',
  description: 'you yell reducto',
  result_id: @spells.id
})

@smoke.actions.create!({
  trigger: 'stupify',
  description: 'you yell stupify',
  result_id: @spells.id
})

@smoke.actions.create!({
  trigger: 'expelliarmus',
  description: 'you yell expelliarmus',
  result_id: @spells.id
})

@spells.actions.create!({
  trigger: 'forward',
  description: 'you walk forward',
  result_id: @cup.id
})

@spells.actions.create!({
  trigger: 'ahead',
  result_id: @cup.id
})

@cup.actions.create!({
  trigger: 'grab',
  description: 'you grab it',
  result_id: @maze_entrance.id
})

@cup.actions.create!({
  trigger: 'take',
  result_id: @maze_entrance.id
})

@cup.actions.create!({
  trigger: 'cup',
  result_id: @maze_entrance.id
})

@cup.actions.create!({
  trigger: 'handle',
  result_id: @maze_entrance.id
})

# Game 2 #

@blue_room.actions.create!({
  trigger: 'north',
  result_id: @red_room.id
})

@blue_room.actions.create!({
  trigger: 'east',
  result_id: @yellow_room.id
})

@red_room.actions.create!({
  trigger: 'south',
  result_id: @blue_room.id
})

@red_room.actions.create!({
  trigger: 'east',
  result_id: @green_room.id
})

@green_room.actions.create!({
  trigger: 'south',
  result_id: @yellow_room.id
})

@green_room.actions.create!({
  trigger: 'west',
  result_id: @red_room.id
})

@yellow_room.actions.create!({
  trigger: 'north',
  result_id: @green_room.id
})

@yellow_room.actions.create!({
  trigger: 'west',
  result_id: @blue_room.id
})
