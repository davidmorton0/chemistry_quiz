require 'test_helper'

class QuestionsShowTest < ActionDispatch::IntegrationTest
  
  test "should show question" do
    @quiz = create(:quiz_10_questions, :correct)
    @question = @quiz.questions.first
    @user = create(:new_user, :admin)
    log_in_as(@user)
    get question_path(@question)
    assert_select "title", "Question #{@question.id}#{base_title}"
    assert_select "p", "Question ID: #{@question.id}"
    assert_select "p", "Quiz ID: #{@question.quiz_id}"
    assert_select "p", "Prompt: #{@question.prompt}"
    assert_select "p", "Answers:"
    assert_select "ul.answer", count: 1 do
      assert_select "li", count: @question.answers.count
      @question.answers.each do |answer|
        assert_select "li", answer.text
      end
    end
    assert_select "p", "Correct Answer: #{@question.correct_answer}"
    assert_select "p", "Answered: #{@question.answered}"
    assert_select "p", "Chosen Answer: #{@question.chosen_answer}"
    assert_select "p", "Created: #{@question.created_at}"
    assert_select "p", "Updated: #{@question.updated_at}"
    assert_select "a[href=?]", questions_path
  end
end
