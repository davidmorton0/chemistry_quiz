require 'test_helper'

class QuizzesControllerTest < ActionDispatch::IntegrationTest
  
  test "should get current quiz start page" do
    @user = users(:michael)
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_no_difference 'Quiz.count' do
      get quiz_url
      assert_response :success
      assert_select "title", "Quiz#{@base_title}"
      assert_select "h1", "Chemical Symbol Quiz"
      assert_match "1. What is the chemical symbol for", response.body
      assert_select "input[type=?]", 'radio', count: 16
      assert_select "input[type=?]", 'submit', count: 5
      assert_equal Quiz.first.id, 5
      assert_equal Quiz.first.difficulty, 2
      assert_equal Quiz.first.score, 1
      assert_equal questions.first.id, 20
      assert_equal questions.second.id, 21
      assert_equal questions.third.id, 22
    end
  end

  test "should start new quiz" do
    @user = users(:michael)
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_no_difference 'Quiz.count' do
      post quizzes_url
      assert_redirected_to quiz_path
      follow_redirect!
      assert_select "title", "Quiz#{@base_title}"
      assert_select "h1", "Chemical Symbol Quiz"
      assert_match "1. What is the chemical symbol for", response.body
      assert_select "input[type=?]", 'radio', count: 40
      assert_select "input[type=?]", 'submit', count: 11
      assert_not_equal 5, Quiz.find_by(user_id: @user.id).id
    end
  end

  test "should create new quiz for new user" do
    @user = users(:mary)
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    
    assert_difference 'Quiz.count', 1 do
      get quiz_url
      assert_response :success
      assert_select "title", "Quiz#{@base_title}"
      assert_select "h1", "Chemical Symbol Quiz"
      assert_match "1. What is the chemical symbol for", response.body
      assert_select "input[type=?]", 'radio', count: 40
      assert_select "input[type=?]", 'submit', count: 11
    end
  end

end
