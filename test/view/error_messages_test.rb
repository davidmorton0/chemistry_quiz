require 'test_helper'

class ErrorMessagesTest < ActionView::TestCase
  
  test "should return blank when no errors" do
    @user = build(:new_user)
    @user.valid?
    partial = render :partial => 'shared/error_messages'
    assert_equal "", partial
  end
  
  test "should show 1 error message" do
    @user = build(:new_user, name: "")
    @user.valid?
    render :partial => 'shared/error_messages'
    assert_select "div", count: 2
    assert_select "div", "The form contains 1 error."
    assert_select "li", @user.errors.full_messages[0]
  end
  
  test "should show 3 error messages" do
    @user = build(:new_user, name: "", password: "", email: "")
    @user.valid?
    render :partial => 'shared/error_messages'
    assert_select "div", count: 2
    assert_select "div", "The form contains 3 errors."
    assert_select "li", @user.errors.full_messages[0]
    assert_select "li", @user.errors.full_messages[1]
    assert_select "li", @user.errors.full_messages[2]
  end
end
