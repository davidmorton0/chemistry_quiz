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
    trait :not_activated do
      activated { false }
    end
  end
  
  factory :new_quiz_type, class: QuizType do
    name { "Chemical Symbol Quiz" }
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