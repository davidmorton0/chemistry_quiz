require 'test_helper'

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = create(:new_user)
  end
  
  test "should get new" do
    get new_password_reset_path
    assert_response :success
    assert_select "title", "Forgot Password#{base_title}"
  end
  
  test "should create a password reset" do
    post password_resets_path,
         params: { password_reset: { email: @user.email } }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "should not create a password reset if user not found" do
    post password_resets_path, params: { password_reset: { email: "" } }
    assert_not flash.empty?
    assert_template 'password_resets/new'
  end
  
  test "should get password reset form for user" do
    @user.create_reset_digest
    get edit_password_reset_path(@user.reset_token, email: @user.email)
    assert_response :success
  end
  
  test "should not get password reset form for no user email" do
    @user.create_reset_digest
    get edit_password_reset_path(@user.reset_token, email: "")
    assert_redirected_to root_path
  end
  
  test "should not get password reset form for invalid reset digest" do
    @user.create_reset_digest
    get edit_password_reset_path(0, email: @user.email)
    assert_redirected_to root_path
  end
  
  test "should not get password reset form if reset digest expired" do
    @user.create_reset_digest
    @user.update(reset_sent_at: 3.hours.ago)
    get edit_password_reset_path(@user.reset_token, email: @user.email)
    assert_not flash.empty?
    assert_redirected_to new_password_reset_url
  end
  
  test "should update password" do
    @user.create_reset_digest
    patch password_reset_path(@user.reset_token),
          params: { email: @user.email,
                    user: { password:              "newpassword",
                            password_confirmation: "newpassword" } }
    assert_not_equal @user.password_digest, @user.reload.password_digest
    assert is_logged_in?
    assert_nil @user.reset_digest
    assert_not flash.empty?
    assert_redirected_to @user
  end
  
  test "should not update empty password" do
    @user.create_reset_digest
    patch password_reset_path(@user.reset_token),
          params: { email: @user.email,
                    user: { password:              "",
                            password_confirmation: "" } }
    assert_equal @user.password_digest, @user.reload.password_digest
    assert_not is_logged_in?
    assert_not_nil @user.reset_digest
    assert flash.empty?
    assert_template 'edit'
  end
  
  test "should not update password if confirmation does not match" do
    @user.create_reset_digest
    patch password_reset_path(@user.reset_token),
          params: { email: @user.email,
                    user: { password:              "newpassword",
                            password_confirmation: "password" } }
    assert_equal @user.password_digest, @user.reload.password_digest
    assert_not is_logged_in?
    assert_not_nil @user.reset_digest
    assert flash.empty?
    assert_template 'edit'
  end
end