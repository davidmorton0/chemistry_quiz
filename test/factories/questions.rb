#makes an answer with question
# options
# :unanswered
# :answered
# :incorrect
# :correct

FactoryBot.define do
  factory :answer_with_question, class: Answer do
    trait :correct do
      text { "Yes" }
    end
    trait :incorrect do
      text { "No" }
    end
    question
  end
end