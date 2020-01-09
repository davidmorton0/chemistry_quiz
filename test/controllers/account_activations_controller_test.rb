require 'test_helper'

class AccountActivationsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    post signup_path, params: { user: { name:  "Example User",
                                       email: "user@example.com",
                                       password:              "password",
                                       password_confirmation: "password" } }
    @user = assigns(:user)
    assert_not @user.activated?
  end
  
  test "should activate user with correct link" do
    get edit_account_activation_path(@user.activation_token, email: @user.email)
    assert @user.reload.activated?
    assert is_logged_in?
    assert_not_nil flash[:success]
    assert_nil flash[:danger]
    assert_redirected_to profile_path
  end
  
  test "should not activate when user not found" do
    get edit_account_activation_path(@user.activation_token, email: 'wrong')
    assert_not @user.activated
    assert_not is_logged_in?
    assert_nil flash[:success]
    assert_not_nil flash[:danger]
    assert_redirected_to root_path
  end
  
  test "should not activate when user already activated" do
    @user.update(activated: true)
    get edit_account_activation_path(@user.activation_token, email: @user.email)
    assert_not is_logged_in?
    assert_nil flash[:success]
    assert_not_nil flash[:danger]
    assert_redirected_to root_path
  end
  
  test "should not activate when user not authenticated" do
    get edit_account_activation_path("invalid token", email: @user.email)
    assert_not @user.activated
    assert_not is_logged_in?
    assert_nil flash[:success]
    assert_not_nil flash[:danger]
    assert_redirected_to root_path
  end
end
