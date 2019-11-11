require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  test "should show user" do
    get user_path(2)
    assert_response :success
    assert_select "title", "#{users[1].name}#{@base_title}"
    assert_match users[1].name, response.body
  end
  
  test "should get new" do
    get signup_path
    assert_response :success
  end

end
