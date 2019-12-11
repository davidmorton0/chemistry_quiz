require 'test_helper'

class QuizTypesViewTest < ActionDispatch::IntegrationTest
=begin
  test "should get quiz type index" do
    @quiz_type = create(:new_quiz_type)
    get quiz_types_path
    assert_response :success
    assert_select "title", "Choose a Quiz#{base_title}"
    assert_select "a[href=?]", quiz_type_path(@quiz_type.id)
    assert_select "td", "#{@quiz_type.description}"
    assert_select "td", "#{@quiz_type.level}"
    assert_select "td", "#{@quiz_type.difficulty}"
    assert_select "td", "#{@quiz_type.num_questions}"
  end
=end
end
