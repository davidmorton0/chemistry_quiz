Score.destroy_all
Answer.destroy_all
Question.destroy_all
Quiz.destroy_all
QuizType.destroy_all
User.destroy_all

Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each do |seed|
  load seed
end

user = User.create!(id: 1,
            name: "Bob",
            email: "bob@example.com",
            password: "password",
            password_confirmation: "password",
            admin: true,
            activated: true,
            activated_at: Time.zone.now)
            
quiz_types = QuizType.all

qt = quiz_types.map{ |m| m.id }.to_a.shuffle
qt.each do |n|
  score = Score.create!(
      score: rand(11),
      user_id: 1,
      quiz_type_id: n)
  if score.score == 10
    score.update(fastest_time: rand(200) + rand(50) + rand(5))
  end
end

10.times do |n|
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
    user.reload
    quiz = Quiz.new
    quiz.make_new_quiz(quiz_types[rand(quiz_types.count)], user.id)
    answer_questions = quiz.questions.shuffle.take(rand(11))
    answer_questions.each do |question|
      question.answer_question(question.answers.shuffle.first.text)
    end
    qt = quiz_types.map{ |m| m.id }.to_a.shuffle
    qt.each do |n|
      score = Score.create!(
          score: rand(11),
          user_id: user.id,
          quiz_type_id: n)
      if score.score == 10
        score.update(fastest_time: rand(200) + rand(50) + rand(5))
      end
    end
end