require 'test_helper'

class UserMailerPasswordResetTextTest < ActionView::TestCase
  
  test "should show password reset mail text" do
    @user = create(:new_user)
    @user.create_reset_digest
    text = render template: 'user_mailer/password_reset.text', handlers: [:erb]
    assert_match (/To reset your password/), text
    path = edit_password_reset_url(@user.reset_token, email: @user.email)
    assert_match path, text
    assert_match (/If you did not request/), text
  end
end
