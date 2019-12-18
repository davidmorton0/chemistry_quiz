require 'test_helper'

class QuizTypesIndexTest < ActionDispatch::IntegrationTest
  
  test "should show quiz_Types index" do
    @quiz_type = create(:new_quiz_type)
    20.times do
      create(:new_quiz_type)
    end
    get quiz_types_path
    assert_select "title", "Choose a Quiz#{base_title}"
    assert_select "div.container" do
      assert_select "h1", "Choose a Quiz"
      assert_select "div.row", count: 1 do
        assert_select "div.col-md-12", count: 1 do
          assert_select "a[href=?]", quiz_types_path(page: 2), count: 4
          assert_select "table" do
            assert_select "colgroup" do
              assert_select "col", count: 5
            end
            assert_select "tr", count: 11
            assert_select "tr:nth-child(2)" do
              assert_select "th", "Quiz Name"
              assert_select "th", "Description"
              assert_select "th", "Level"
              assert_select "th", "Difficulty"
              assert_select "th", "Number of Questions"
            end
            assert_select "tr:nth-child(3)" do
              assert_select "td", @quiz_type.name
              assert_select "td", @quiz_type.description
              assert_select "td", @quiz_type.level.to_s
              assert_select "td", @quiz_type.difficulty.to_s
              assert_select "td", @quiz_type.num_questions.to_s
            end
          end
        end
      end
    end
  end
end
