require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = create(:admin)
    @non_admin = create(:user)
  end
  
  test "should redirect to login if attempt to logout when not logged in" do
  end
  
  test "should redirect from index to login when not logged in" do
    delete logout_path
    get users_path
    assert_redirected_to login_path
  end
  
  test "should redirect from index to root when logged in as non admin" do
    log_in_as(@non_admin)
    get users_path
    assert_redirected_to root_url
  end
  
  test "should get index when logged in as admin" do
    log_in_as(@admin)
    get users_path
    assert_response :success
    assert_select "title", "All users#{base_title}"
    assert_select "a[href=?]", user_path(User.second)
  end
  
  test "should get other user when logged in as admin" do
    log_in_as(@admin)
    get user_path(@non_admin)
    assert_response :success
    assert_select "h1", @non_admin.name
  end
  
  test "should not get other user when not logged in as admin" do
    log_in_as(@non_admin)
    get user_path(@admin)
    assert_response :success
    assert_select "h1", @non_admin.name
  end
  
  test "should show user" do
    log_in_as(@non_admin)
    get user_path(@non_admin)
    assert_response :success
    assert_template "show"
    assert_match @non_admin.name, response.body
  end
  
  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    delete logout_path
    get edit_user_path(@non_admin)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    delete logout_path
    patch user_path(@non_admin), params: { user: { name: @non_admin.name,
                                              email: @non_admin.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@non_admin)
    get edit_user_path(@admin)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@non_admin)
    patch user_path(@admin), params: { user: { name: @admin.name,
                                              email: @admin.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@non_admin)
    assert_not @non_admin.admin?
    patch user_path(@non_admin), params: {
                                    user: { password:              "password",
                                            password_confirmation: "password",
                                            admin: true } }
    assert_not @non_admin.reload.admin?
  end
  
  test "should redirect destroy when not logged in" do
    delete logout_path
    assert_no_difference 'User.count' do
      delete user_path(@non_admin)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@non_admin)
    assert_no_difference 'User.count' do
      delete user_path(@non_admin)
    end
    assert_redirected_to root_url
  end
end
