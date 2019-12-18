#makes a valid 10 question quiz. Each question has 4 answers
#options:

# :unanswered - all questions unanswered
# :incorrect - all questions answered incorrectly
# :correct - all questions answered correctly
# :with_score_5 - with score = 5
# :with_score_10_1m  - with score = 10 and fastest time 1min
# :with_score_10_10m - with score = 10 and fastest time 10min

FactoryBot.define do
  factory :quiz_10_questions, class: Quiz do
    created_at { 5.minutes.ago }
    score { 0 }
    
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
    
    #answered incorrectly
    trait :incorrect do
      score { 0 }
      after :create do |quiz|
        create_list :question_with_answers, 10, :incorrect, quiz: quiz
      end
    end
    
    #answered correctly
    trait :correct do
      score { 10 }
      after :create do |quiz|
        create_list :question_with_answers, 10, :correct, quiz: quiz
      end
    end
    
    #with scores
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