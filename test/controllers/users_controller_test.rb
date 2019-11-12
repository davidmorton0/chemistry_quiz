require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include SessionsHelper
  
  test "should show user" do
    @user = users[1]
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    get user_path(@user)
    assert_response :success
    assert_select "title", "#{@user.name}#{@base_title}"
    assert_match @user.name, response.body
  end
  
  test "should get new" do
    get signup_path
    assert_response :success
  end

end
