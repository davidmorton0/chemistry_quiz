require 'test_helper'

class UserMailerAccountActivationHtmlTest < ActionView::TestCase
  
  test "should show account activation mail html" do
    @user = create(:new_user)
    render template: 'user_mailer/account_activation'
    assert_select "h1", "Chemistry Quiz", count: 1
    assert_select "p", "Hi #{@user.name},", count: 1
    assert_select "p", /Welcome to Chemistry Quiz/, count: 1
    path = edit_account_activation_url(@user.activation_token,
                                       email: @user.email)
    assert_select "a[href=?]", path, count: 1
  end
end
