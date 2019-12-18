require 'test_helper'

class UserMailerPasswordResetHtmlTest < ActionView::TestCase
  
  test "should show password reset mail html" do
    @user = create(:new_user)
    @user.create_reset_digest
    render template: 'user_mailer/password_reset'
    assert_select "h1", "Password reset", count: 1
    assert_select "p", /To reset your password/, count: 1
    path = edit_password_reset_url(@user.reset_token, email: @user.email)
    assert_select "a[href=?]", path, count: 1
    assert_select "p", /If you did not request/, count: 1
  end
end
