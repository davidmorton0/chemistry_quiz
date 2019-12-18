require 'test_helper'

class QuizzesShowTest < ActionDispatch::IntegrationTest
  
  test "should show correct quiz" do
    @quiz = create(:quiz_10_questions, :correct)
    log_in_as(@quiz.user)
    get quiz_path(@quiz)
    assert_template 'quizzes/show'
    assert_select "title", "Quiz#{base_title}"
    assert_match (/\u{2714}/), response.body
    assert_no_match (/\u{274C}/), response.body
    assert_select "div.container" do
      assert_select "div.row" do
        assert_template partial: '_info'
      end
      assert_select "form" do
        assert_select "div.row" do
          assert_select "div.grid-container" do
            assert_template partial: '_question', count: 10
            assert_template partial: '_answer', count: 40
            (1..10).each do |n|
              assert_select "div.grid-item" do
                assert_select "div.prompt" do
                  assert_select "p", "#{n}. #{@quiz.questions[n-1].prompt}"
                end
                assert_select "div.answerbox" do
                  @quiz.questions[n-1].answers.each do |answer|
                    assert_select "div.radio" do
                      assert_select "input#quiz_#{answer.question.id}_#{answer.text.downcase}"
                      assert_select "label", answer.text + (answer.text == answer.question.correct_answer ? " \u{2714}" : "")
                    end
                  end
                end
                assert_select "button.answer", "Answer", count: 1
              end
            end
          end
        end
        assert_select "div.row" do
          assert_select "div.col-sm-12" do
            assert_select "button.answerall", "Answer All", count: 1
          end
        end
      end
    end
  end
  
  test "should show incorrect quiz" do
    @quiz = create(:quiz_10_questions, :incorrect)
    log_in_as(@quiz.user)
    get quiz_path(@quiz)
    assert_template 'quizzes/show'
    assert_select "title", "Quiz#{base_title}"
    assert_no_match (/\u{2714}/), response.body
    assert_match (/\u{274C}/), response.body
    assert_select "div.container" do
      assert_select "div.row" do
        assert_template partial: '_info'
      end
      assert_select "form" do
        assert_select "div.row" do
          assert_select "div.grid-container" do
            assert_template partial: '_question', count: 10
            assert_template partial: '_answer', count: 40
            (1..10).each do |n|
              assert_select "div.grid-item" do
                assert_select "div.prompt" do
                  assert_select "p", "#{n}. #{@quiz.questions[n-1].prompt}"
                end
                assert_select "div.answerbox" do
                  @quiz.questions[n-1].answers.each do |answer|
                    assert_select "div.radio" do
                      assert_select "input#quiz_#{answer.question.id}_#{answer.text.downcase}"
                      assert_select "label", answer.text + (answer.text == answer.question.chosen_answer ? " \u{274C}" : "")
                    end
                  end
                end
                assert_select "button.answer", "Answer", count: 1
              end
            end
          end
        end
        assert_select "div.row" do
          assert_select "div.col-sm-12" do
            assert_select "button.answerall", "Answer All", count: 1
          end
        end
      end
    end
  end
  
  test "should show unanswered quiz" do
    @quiz = create(:quiz_10_questions, :unanswered)
    log_in_as(@quiz.user)
    get quiz_path(@quiz)
    assert_template 'quizzes/show'
    assert_select "title", "Quiz#{base_title}"
    assert_no_match (/\u{274C}/), response.body
    assert_no_match (/\u{2714}/), response.body
    assert_select "div.container" do
      assert_select "div.row" do
        assert_template partial: '_info'
      end
      assert_select "form" do
        assert_select "div.row" do
          assert_select "div.grid-container" do
            assert_template partial: '_question', count: 10
            assert_template partial: '_answer', count: 40
            (1..10).each do |n|
              assert_select "div.grid-item" do
                assert_select "div.prompt" do
                  assert_select "p", "#{n}. #{@quiz.questions[n-1].prompt}"
                end
                assert_select "div.answerbox" do
                  @quiz.questions[n-1].answers.each do |answer|
                    assert_select "div.radio" do
                      assert_select "input#quiz_#{answer.question.id}_#{answer.text.downcase}"
                      assert_select "label", answer.text
                    end
                  end
                end
                assert_select "button.answer", "Answer", count: 1
              end
            end
          end
        end
        assert_select "div.row" do
          assert_select "div.col-sm-12" do
            assert_select "button.answerall", "Answer All", count: 1
          end
        end
      end
    end
  end
end
