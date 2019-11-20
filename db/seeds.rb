Score.destroy_all
Answer.destroy_all
Question.destroy_all
Quiz.destroy_all
QuizType.destroy_all
User.destroy_all

user = User.create!(id: 1,
            name: "Bob",
            email: "bob@example.com",
            password: "password",
            password_confirmation: "password",
            admin: true,
            activated: true,
            activated_at: Time.zone.now)
            
quiz1 = QuizType.create!(name: "Chemical Symbol Quiz",
                level: 1,
                num_questions: 10,
                difficulty: 1)

quiz2 = QuizType.create!(name: "Chemical Symbol Quiz",
                level: 2,
                num_questions: 10,
                difficulty: 2)

quiz3 = QuizType.create!(name: "Chemical Symbol Quiz",
                level: 3,
                num_questions: 10,
                difficulty: 4)

quiz4 = QuizType.create!(name: "Chemical Element Quiz",
                level: 1,
                num_questions: 10,
                difficulty: 1)

quiz5 = QuizType.create!(name: "Chemical Element Quiz",
                level: 2,
                num_questions: 10,
                difficulty: 2)
                
quiz6 = QuizType.create!(name: "Chemical Element Quiz",
                level: 3,
                num_questions: 10,
                difficulty: 4)
                
Score.create!(  score: 6,
                user_id: user.id,
                quiz_type_id: quiz2.id)

9.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@example.co.uk"
    password = "password"
    user = User.create!(
        name: name,
        email: email,
        password: password,
        password_confirmation: password,
        activated: true,
        activated_at: Time.zone.now)
    Score.create!(
        score: 5,
        user_id: user.id,
        quiz_type_id: quiz3.id)
end