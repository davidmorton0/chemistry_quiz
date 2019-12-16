require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  include SessionsHelper
  include ValidationMethods

  test "should get new" do
    get login_path
    assert_response :success
  end

  test "should create session with valid login and remember" do
    @user = create(:new_user)
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password',
                                          remember_me: 1      } }
    assert_equal session[:user_id], @user.id
    assert_not_nil @user.reload.remember_digest
  end
  
  test "should create session with valid login without remember" do
    @user = create(:new_user)
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password',
                                          remember_me: 0      } }
    assert_equal session[:user_id], @user.id
    assert_nil @user.reload.remember_digest
    assert_redirected_to @user
  end
  
  test "should redirect to a stored location" do
    @quiz = create(:new_quiz)
    @user = @quiz.user
    get quiz_path
    assert_redirected_to login_path
    assert_equal session[:forwarding_url], quiz_url
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password'} }
    assert_redirected_to quiz_path
    assert_nil session[:forwarding_url]
  end
  
  test "should redirect to a default location when no stored location" do
    @quiz = create(:new_quiz)
    @user = @quiz.user
    patch quiz_path(@quiz)
    assert_redirected_to login_path
    assert_nil session[:forwarding_url]
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password'} }
    assert_redirected_to user_path(@user)
  end
  
  test "should not log in with unknown user" do
    post login_path, params: { session: { email:    "email",
                                          password: 'password' } }
    assert_nil session[:user_id]
    assert_not flash.empty?
    assert_template 'new'
  end
  
  test "should not log in with incorrect password" do
    @user = create(:new_user)
    post login_path, params: { session: { email:    @user.email,
                                          password: 'wrongpassword' } }
    assert_nil session[:user_id]
    assert_nil @user.reload.remember_token
    assert_not flash.empty?
    assert_template 'new'
  end
  
  test "should not create session with non-activated user" do
    @user = create(:new_user, :not_activated)
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert_nil session[:user_id]
    assert_nil @user.reload.remember_token
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test "should log out" do
    @user = create(:new_user)
    log_in_as @user
    assert_equal session[:user_id], @user.id
    delete logout_path
    assert_nil session[:user_id]
    assert_redirected_to root_path
  end
  
  test "should stored location for forwarding if get request" do
    @user = create(:new_user)
    get user_path(@user)
    assert_equal session[:forwarding_url], user_url(@user)
  end
  
  test "should not stored location for forwarding for other (patch) request" do
    @user = create(:new_user)
    patch user_path(@user)
    assert_not_equal session[:forwarding_url], user_url(@user)
  end
end