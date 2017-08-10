# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

State.destroy_all

@state1 = State.create! description: 'knock knock'
@state2 = State.create! description: 'dwayne'
@state3 = State.create! description: 'dwayne the tub, I\'m dwowning'
@state4 = State.create! description: 'wanna hear it again?'
@state5 = State.create! description: 'too bad! knock knock'

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