require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = create(:new_user, :admin)
    @non_admin = create(:new_user)
  end

  test "should redirect from index to login when not logged in" do
    get users_path
    assert_redirected_to login_path
  end
  
  test "should redirect from index to root when logged in as non admin" do
    log_in_as(@non_admin)
    assert_not_nil session[:user_id]
    get users_path
    assert_redirected_to root_url
  end
  
  test "should get index when logged in as admin" do
    log_in_as(@admin)
    assert_not_nil session[:user_id]
    get users_path
    assert_response :success
    assert_select "title", "All users#{base_title}"
  end
  
  test "should show user when logged in as admin" do
    log_in_as(@admin)
    get user_path(@non_admin)
    assert_response :success
    assert_select "h1", @non_admin.name
  end
  
  test "should not show user when not logged in" do
    delete logout_path
    get user_path(@admin)
    assert_redirected_to login_path
  end
  
  test "should not show user when not logged in as admin" do
    log_in_as(@non_admin)
    get user_path(@admin)
    assert_redirected_to root_path
  end
  
  test "should show user profile" do
    log_in_as(@non_admin)
    get profile_path
    assert_response :success
    assert_template "show"
    assert_match @non_admin.name, response.body
  end
  
  test "should not show user profile if logged out" do
    delete logout_path
    get profile_path
    assert_redirected_to login_path
  end
  
  test "should show score on user profile" do
    @score = create(:new_score)
    log_in_as(@score.user)
    get profile_path
    assert_response :success
    assert_equal assigns(:scores).count, 1
  end
  
  test "should get new" do
    get signup_path
    assert_response :success
  end
  
  test "should create valid user" do
    post signup_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test "should not create invalid user" do
    post signup_path, params: { user: { name:  "",
                                        email: "user@invalid",
                                        password:              "foo",
                                        password_confirmation: "bar" } }
    assert_template 'new'
  end

  test "should get edit when logged in" do
    log_in_as(@non_admin)
    get edit_user_path(@non_admin)
    assert_response :success
    assert flash.empty?
  end

  test "should redirect edit when not logged in" do
    delete logout_path
    get edit_user_path(@non_admin)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@non_admin)
    get edit_user_path(@admin)
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should allow profile to be updated" do
    log_in_as(@non_admin)
    patch user_path(@non_admin), params: {
                                    user: { name: "#{@non_admin.name} 1" } }
    assert_not_equal @non_admin.name, @non_admin.reload.name
  end

  test "should redirect update when not logged in" do
    delete logout_path
    patch user_path(@non_admin), params: { user: { name: @non_admin.name,
                                                   email: @non_admin.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
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
  
  test "should delete user as admin" do
    log_in_as(@admin)
    delete user_path(@non_admin)
    assert_raises(ActiveRecord::RecordNotFound) do
      @non_admin.reload
    end
    assert_not flash.empty?
    assert_redirected_to users_url
  end
  
  test "should redirect delete user when not logged in" do
    delete logout_path
    assert_no_difference 'User.count' do
      delete user_path(@non_admin)
    end
    assert_redirected_to login_url
  end

  test "should redirect delete user when logged in as a non-admin" do
    log_in_as(@non_admin)
    assert_no_difference 'User.count' do
      delete user_path(@non_admin)
    end
    assert_redirected_to root_url
  end
end
