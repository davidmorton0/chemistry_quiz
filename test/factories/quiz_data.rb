#make new valid versions of data holders

FactoryBot.define do
  factory :new_user, class: User do
    sequence(:name) { |n| "New User #{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password_digest { User.digest('password') }
    activated { true }
    activated_at { Time.zone.now }
    trait :admin do
      admin { true }
    end
    trait :unactivated do
      activated { false }
    end
  end
  
  factory :new_quiz_type, class: QuizType do
    sequence(:name) { |n| "New Quiz Type #{n}" }
    num_questions { 10 }
    difficulty { 1 }
    description { "A Quiz" }
    level { 1 }
  end
  
  factory :new_quiz, class: Quiz do
    score { 0 }
    created_at { 5.minutes.ago }
    
    before :create do |quiz|
      quiz.user = create(:new_user)
      quiz.quiz_type = create(:new_quiz_type)
    end
  end

  factory :new_question, class: Question do
    prompt { "Question?" }
    correct_answer { "Yes" }
    answered { false }
    chosen_answer { nil }
    
    before :create do |question|
      question.quiz = create(:new_quiz)
    end
  end
  
  factory :new_answer, class: Answer do
    text { "Answer" }
    
    before :create do |answer|
      answer.question = create(:new_question)
    end
  end

  factory :new_score, class: Score do
    score { 0 }
    before :create do |score|
      score.user = create(:new_user)
      score.quiz_type = create(:new_quiz_type)
    end
    trait :score_5 do
      score { 5 }
    end
    trait :score_10_5_min do
      score { 10 }
      fastest_time { 300 }
    end
    trait :score_10_1_min do
      score { 10 }
      fastest_time { 60 }
    end
  end
end

#makes a 10 question quiz, unanswered/incorrect/correct. Each question has 4 answers

FactoryBot.define do
  factory :quiz_10_questions, class: Quiz do
    created_at { 5.minutes.ago }
    
    before :create do |quiz|
      quiz.user = create(:new_user)
      quiz.quiz_type = create(:new_quiz_type)
    end
    
    trait :unanswered do
      score { 0 }
      after :create do |quiz|
        create_list :question_with_answers, 10, :unanswered, quiz: quiz
      end
    end
    trait :incorrect do
      score { 0 }
      after :create do |quiz|
        create_list :question_with_answers, 10, :incorrect, quiz: quiz
      end
    end
    trait :correct do
      score { 10 }
      after :create do |quiz|
        create_list :question_with_answers, 10, :correct, quiz: quiz
      end
    end
    trait :with_score_5 do
      after :create do |quiz|
        create :score_5, quiz_type: quiz.quiz_type, user: quiz.user
      end
    end
    trait :with_score_10_1m do
      after :create do |quiz|
        create :score_10_1m, quiz_type: quiz.quiz_type, user: quiz.user
      end
    end
    trait :with_score_10_10m do
      after :create do |quiz|
        create :score_10_10m, quiz_type: quiz.quiz_type, user: quiz.user
      end
    end
  end

  factory :question_with_answers, class: Question do
    prompt { "Question?" }
    correct_answer { "Yes" }
    trait :unanswered do
      answered { false }
      chosen_answer { nil }
    end
    trait :incorrect do
      answered { true }
      chosen_answer { "No" }
    end
    trait :correct do
      answered { true }
      chosen_answer { "Yes" }
    end
    
    after :create do |question|
      create :correct_answer, question: question
      create_list :wrong_answer, 3, question: question
    end
  end
  
  factory :correct_answer, class: Answer do
    text { "Yes" }
  end
  
  factory :wrong_answer, class: Answer do
    text { "No" }
  end
  factory :score_5, class: Score do
    score { 5 }
  end
  factory :score_10_1m, class: Score do
    score { 10 }
    fastest_time { 60 }
  end
  factory :score_10_10m, class: Score do
    score { 10 }
    fastest_time { 600 }
  end
end