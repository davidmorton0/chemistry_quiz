require 'test_helper'

class QuizClassesTest < ActiveSupport::TestCase
  
  test "symbol quiz test" do
    (1..3).each do |level|
      question_index = SymbolQuiz.new(quiz_types(:one), 50).select_questions(level)
      assert_equal question_index.length, question_index.uniq.length
      assert_operator question_index.length, :>=, 10
    end
  end

end