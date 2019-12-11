FactoryBot.define do
  factory :user do
    id { 60 }
    name { "Example User" }
    email { "user@example.com" }
    password_digest { User.digest('password') }
    activated { true }
    activated_at { Time.zone.now }
  end

  factory :admin, class: User do
    id { 61 }
    name { "Michael Example" }
    email { "admin@example.com" }
    password_digest { User.digest('password') }
    admin { true }
    activated { true }
    activated_at { Time.zone.now }
  end
end

FactoryBot.define do
  factory :quiz, class: Quiz do
    id { 50 }
    score { 10 }
    user_id { 60 }
    quiz_type_id { 1 }
    created_at { 5.minutes.ago }
  end
end

FactoryBot.define do
  factory :admin_quiz, class: Quiz do
    id { 51 }
    score { 10 }
    user_id { 61 }
    quiz_type_id { 1 }
    created_at { 5.minutes.ago }
  end
end

FactoryBot.define do
  factory :answer_yes, class: Answer do
    text { "Yes" }
    question_id { nil }
  end
end

FactoryBot.define do
  factory :answer_no, class: Answer do
    text { "No" }
    question_id { nil }
  end
end

FactoryBot.define do
  factory :question do
    prompt { "What?" }
    correct_answer { "Yes" }
    quiz_id { 50 }
    answered { false }
    chosen_answer { nil }
  end
  
  trait :with_answers do
    after(:create) do |question|
      create(:answer_yes, question_id: question.id)
      create(:answer_no, question_id: question.id)
    end
  end
end

FactoryBot.define do
  factory :score5, class: Score do
    quiz_type_id { 1 }
    score { 5 }
    user_id { 60 }
  end
  
  factory :score10, class: Score do
    quiz_type_id { 1 }
    score { 5 }
    user_id { 60 }
  end

  factory :fastscore, class: Score do
    quiz_type_id { 1 }
    score { 10 }
    user_id { 60 }
    fastest_time { 50 }
  end

  factory :slowscore, class: Score do
    quiz_type_id { 1 }
    score { 10 }
    user_id { 60 }
    fastest_time { 1000 }
  end
end

FactoryBot.define do
  factory :quiz_type do
    id { 1 }
    name { "Quiz" }
    num_questions { 10 }
    difficulty { 3 }
    description { "A Quiz" }
    level { 3 }
  end
  
  factory :quiz_types, class: QuizType do
    name { "Quiz #{Quiz.count + 1}" }
    num_questions { 10 }
    difficulty { 1 }
    description { "A Quiz" }
    level { 1 }
  end
  
  factory :chem_sym_quiz_type do
    name { "Chemical Symbol Quiz" }
    num_questions { 10 }
    difficulty { 3 }
    description { "A Quiz" }
    level { 3 }
  end
end