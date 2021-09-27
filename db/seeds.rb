# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Task.destroy_all
User.destroy_all

user1 = User.create(
  {
    username: 'MayaPapaya', 
    password: 'maya1', 
    firstname: 'Maya', 
    lastname: 'Papaya',
  }
)

Task.create(
  [
    {
      user: user1,
      description: 'Do dishes', 
      priority: 1, 
      completed: false, 
      category: 'Household'
    }, 
    {
      user: user1,
      description: 'Meeting with boss', 
      priority: 3, 
      completed: true, 
      category: 'Work'
    }, 
    {
      user: user1,
      description: 'Get drinks with friends', 
      priority: 2, 
      completed: false, 
      category: 'Social'
    }, 
    {
      user: user1,
      description: 'Read emails', 
      priority: 1, 
      completed: true, 
      category: 'Work'
    },
    {
      user: user1,
      description: 'Brush teeth', 
      priority: 2, 
      completed: true, 
      category: 'Personal'
    }
  ]
)