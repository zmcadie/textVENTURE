# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

State.destroy_all

@maze_entrance = State.create! id: 1, description: "'Champions, welcome to the third and final task of the Tri-Wizard tournament! In the center of the maze that lies before you, you will find the Tri-Wizard Cup.' You walk towards the entrace of the maze. 'Champions, good luck, and remember you can call for help at any time!' Do you want to enter the maze?"

@enter = State.create! description: "As you enter the maze, the bushes close behind you, your breathing is the only sound. There's no turning back now. Ahead, the maze forks into two paths leading off to your left and to your right. Where do you want to go?"

@no_enter = State.create! description: "Scared, you turn to run back into the crowd but Mad-eye grabs your shoulder and shoves you into the maze. The bushes close behind you, your breathing is the only sound. There's no turning back now. Ahead, the maze forks into two paths leading off to your left and to your right. Where do you want to go?"

@right = State.create! description: "You turn right and run down the narrow dirt path. Up ahead and to your left, you hear screaming. To your right you see a small puff of smoke."

@left = State.create! description: "You turn left and sprint forward. Tripping over a root your face slams into the ground, breaking your glasses. No matter, 'Repairo!' Hermione has taught you well. Up ahead the path forks again, to your left you hear a low grumbling and to your right the way seems clear."

@smoke = State.create! description: "A blast ended skrewt! Ten feet long, it looks more like a giant scorpion than anything. Its long sting is curled over its back. Its thick armor glints in the light from your wand. Darting back behind the corner of the bushes you run through a few spells under your breath... 'Reducto, Stupify, Expelliarmus...' It must have smelled your fear, for it trundles around the corner, both blasters trained menacingly on you. You raise your wand and shout:"

@spells = State.create! description: "You manage to hit it square in its fleshy, shell-less underside. It flies twenty feet into the air and hits the ground behind you with a sickening crunch. Phew! That was close! Looking around you see the maze leaves you with no option but to go forward."

@cup = State.create! description: "Ahead you see a slight blue gleam is shimmering. That's it! The Triwizard Cup stands gleaming on a plinth a hundred yards away. You sprint forward and reaching it, hold a hand out over one of it's gleaming handles. Victory is so close. You only need to reach out at grab it."

Action.destroy_all

@maze_entrance.actions.create!({
  trigger: 'no',
  result_id: @no_enter.id
})

@maze_entrance.actions.create!({
  trigger: 'yes',
  result_id: @enter.id
})

@enter.actions.create!({
  trigger: 'left',
  result_id: @left.id
})

@enter.actions.create!({
  trigger: 'right',
  result_id: @right.id
})

@no_enter.actions.create!({
  trigger: 'left',
  result_id: @left.id
})

@no_enter.actions.create!({
  trigger: 'right',
  result_id: @right.id
})

@right.actions.create!({
  trigger: 'left',
  result_id: @left.id
})

@right.actions.create!({
  trigger: 'screaming',
  result_id: @left.id
})

@right.actions.create!({
  trigger: 'right',
  result_id: @smoke.id
})

@right.actions.create!({
  trigger: 'smoke',
  result_id: @smoke.id
})

@left.actions.create!({
  trigger: 'left',
  result_id: @smoke.id
})

@left.actions.create!({
  trigger: 'grumbling',
  result_id: @smoke.id
})

@left.actions.create!({
  trigger: 'right',
  result_id: @cup.id
})

@left.actions.create!({
  trigger: 'clear',
  result_id: @cup.id
})

@smoke.actions.create!({
  trigger: 'reducto',
  result_id: @spells.id
})

@smoke.actions.create!({
  trigger: 'stupify',
  result_id: @spells.id
})

@smoke.actions.create!({
  trigger: 'expelliarmus',
  result_id: @spells.id
})

@spells.actions.create!({
  trigger: 'forward',
  result_id: @cup.id
})

@spells.actions.create!({
  trigger: 'ahead',
  result_id: @cup.id
})

@cup.actions.create!({
  trigger: 'grab',
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