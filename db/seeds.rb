# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(id: 1,
            name: "Bob",
            email: "bob@example.com",
            password: "password",
            password_confirmation: "password",
            admin: true)
            
QuizType.create(id: 1,
                name: "Chemical Symbol Quiz",
                num_questions: 10,
                difficulty: 3)
                
Score.create( id: 1,
              score: 5,
              user_id: 1,
              quiz_type_id: 1)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@example.co.uk"
  password = "password"
  User.create!( name: name,
                email: email,
                password: password,
                password_confirmation: password)
end