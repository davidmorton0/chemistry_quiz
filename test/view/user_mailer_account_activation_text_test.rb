require 'test_helper'

class UserMailerAccountActivationTextTest < ActionView::TestCase
  
  test "should show account activation mail text" do
    @user = create(:new_user)
    text = render template: 'user_mailer/account_activation.text', handlers: [:erb]
    assert_match @user.name, text
    assert_match (/Welcome to Chemistry Quiz/), text
    path = edit_account_activation_url(@user.activation_token, email: @user.email)
    assert_match path, text
  end
end
