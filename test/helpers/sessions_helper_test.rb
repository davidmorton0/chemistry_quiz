require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = create(:user)
  end
  
  test "should log in user" do
    assert_not_equal session[:user_id], @user.id
    log_in(@user)
    assert_equal session[:user_id], @user.id
  end
  
  test "should remember user" do
    remember(@user)
    assert_not_nil @user.remember_token
    assert_equal cookies.permanent.signed[:user_id], @user.id
    assert_equal cookies[:remember_token], @user.remember_token
  end
  
  test "should check current user is user" do
    assert_not current_user?(@user)
    log_in(@user)
    assert current_user?(@user)
  end
  
  test "current_user should return nil if user not logged in or remembered" do
    assert_nil current_user
  end
  
  test "current_user should return right user through session" do
    assert_nil current_user
    log_in(@user)
    assert_equal @user, current_user
  end
  
  test "current_user should return nil when user not saved in database" do
    @user = build(:new_user)
    log_in(@user)
    assert_nil current_user
  end
  
  test "current_user should return nil when session is nil" do
    log_in(@user)
    assert_equal @user, current_user
    session[:user_id] = nil
    assert_nil current_user
  end

  test "current_user should return user through cookie" do
    session[:user_id] = nil
    assert_nil current_user
    remember(@user)
    assert_equal @user, current_user
    assert logged_in?
  end

  test "current_user should return nil when no cookie" do
    remember(@user)
    assert_equal @user, current_user
    session[:user_id] = nil
    cookies.signed[:user_id] = nil
    assert_nil current_user
    assert_not logged_in?
  end
  
  test "current_user should return nil when user deleted from database" do
    remember(@user)
    assert_equal @user, current_user
    session[:user_id] = nil
    @user.destroy
    assert_nil current_user
  end
  
  test "current_user should return nil when remember digest is wrong" do
    remember(@user)
    assert_equal @user, current_user
    session[:user_id] = nil
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
  
  test "should return true if current_user exists" do
    log_in(@user)
    assert_equal @user, current_user
    assert logged_in?
  end
  
  test "should return false if no current_user" do
    assert_not_equal @user, current_user
    assert_not logged_in?
  end

  test "should forget a persistent session" do
    remember(@user)
    assert_not_nil  @user.remember_digest
    assert_not_nil cookies.permanent.signed[:user_id]
    assert_not_nil cookies.permanent[:remember_token]
    forget(@user)
    assert_nil  @user.remember_digest
    assert_nil cookies.permanent.signed[:user_id]
    assert_nil cookies.permanent[:remember_token]
  end
  
  test "should logout a user" do
    log_in(@user)
    remember(@user)
    assert_equal  session[:user_id], @user.id
    assert_not_nil  @user.remember_digest
    assert_not_nil cookies.permanent.signed[:user_id]
    assert_not_nil cookies.permanent[:remember_token]
    log_out
    assert_not_equal  session[:user_id], @user.id
    assert_nil  @user.reload.remember_digest
    assert_nil cookies.permanent.signed[:user_id]
    assert_nil cookies.permanent[:remember_token]
    assert_nil  @current_user
  end
end