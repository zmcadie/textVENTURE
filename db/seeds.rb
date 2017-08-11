# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

State.destroy_all

@maze_entrance = State.create! description: "'Champions, welcome to the third and final task of the Tri-Wizard tournament! In the center of the maze that lies before you, you will find the Tri-Wizard Cup.' You walk towards the entrace of the maze. 'Champions, good luck, and remember you can call for help at any time!' Do you want to enter the maze?" (yes => enter, no => no_enter)

@enter = State.create! description: "As you enter the maze, the bushes close behind you, your breathing is the only sound. There's no turning back now. Ahead, the maze forks into two paths leading off to your left and to your right. Where do you want to go?" (left => left, right => right)

@no_enter = State.create! description: "Scared, you turn to run back into the crowd but Mad-eye grabs your shoulder and shoves you into the maze. The bushes close behind you, your breathing is the only sound. There's no turning back now. Ahead, the maze forks into two paths leading off to your left and to your right. Where do you want to go?"
(left => left, right => right)

@right = State.create! description: "You turn right and run down the narrow dirt path. Up ahead and to your right, you hear screaming. To your left you see a small puff of smoke."
(left => left, screaming => left, right => smoke, smoke => smoke)

@left = State.create! description: "You turn left and sprint forward. Tripping over a root your face slams into the ground, breaking your glasses. No matter, 'Repairo!' Hermione has taught you well. Up ahead the path forks again, to your left you hear a low grumbling and to your right the way seems clear." (left => smoke, grumbling => smoke, right => cup)

@smoke = State.create! description: "A blast ended skrewt! Ten feet long, it looks more like a giant scorpion than anything. Its long sting is curled over its back. Its thick armor glints in the light from your wand. Darting back behind the corner of the bushes you run through a few spells under your breath... 'Reducto, Stupify, Expelliarmus...' It must have smelled your fear, for it trundles around the corner, both blasters trained menacingly on you. You raise your wand and shout"
(reducto => spells, stupify => spells, expelliarmus => spells)

@spells = State.create! description: "You manage to hit it square in its fleshy, shell-less underside. It flies twenty feet into the air and hits the ground behind you with a sickening crunch. Phew! That was close! Looking around you see the maze leaves you with no option but to go forward." (backwards behind forward ahead => cup.)

@cup = State.creat! description: "Ahead you see a slight blue gleam is shimmering. That's it! The Triwizard Cup stands gleaming on a plinth a hundred yards away. You sprint forward and reaching it, hold a hand out over one of it's gleaming handles. Victory is so close. You only need to reach out at grab it." (grab, take, cup => maze_entrance)

Action.destroy_all

@state1.actions.create!({
  trigger: 'who\'s there',
  result_id: @state2.id
})

@state2.actions.create!({
  trigger: 'dwayne who',
  result_id: @state3.id
})

@state3.actions.create!({
  trigger: 'haha',
  result_id: @state4.id
})

@state4.actions.create!({
  trigger: 'yes',
  result_id: @state1.id
})

@state4.actions.create!({
  trigger: 'no',
  result_id: @state5.id
})

@state5.actions.create!({
  trigger: 'who\'s there',
  result_id: @state2.id
})




