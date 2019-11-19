require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
  end
  
  test "layout links when logged in as admin" do
    @user = @admin
    log_in_as(@user)
    get root_path
    assert_template 'chem_pages/home'
    assert_select "a[href=?]", root_path, count: 4
    assert_select "a[href=?]", user_path(@user), count: 1
    assert_select "a[href=?]", users_path, count: 1
    assert_select "a[href=?]", help_path, count: 1
    assert_select "a[href=?]", about_path, count: 1
    assert_select "a[href=?]", contact_path, count: 1
    assert_select "a[href=?]", signup_path, count: 1
    assert_select "a[href=?]", quiz_types_path, count: 1
    assert_select "a[href=?]", quizzes_path, count: 1
    assert_select "a[href=?]", logout_path, count: 1
    assert_select "a[href=?]", edit_user_path(@user), count: 1
    assert_select "a[href=?]", "#", count: 1
    assert_select "a", count: 15
  end
  
  test "layout links when logged in as non-admin" do
    @user = @non_admin
    log_in_as(@user)
    get root_path
    assert_template 'chem_pages/home'
    assert_select "a[href=?]", root_path, count: 4
    assert_select "a[href=?]", user_path(@user), count: 1
    assert_select "a[href=?]", help_path, count: 1
    assert_select "a[href=?]", about_path, count: 1
    assert_select "a[href=?]", contact_path, count: 1
    assert_select "a[href=?]", signup_path, count: 1
    assert_select "a[href=?]", quiz_types_path, count: 1
    assert_select "a[href=?]", quizzes_path, count: 1
    assert_select "a[href=?]", logout_path, count: 1
    assert_select "a[href=?]", edit_user_path(@user), count: 1
    assert_select "a[href=?]", "#", count: 1
    assert_select "a", count: 14
  end
  
  test "layout links when logged out" do
    delete logout_path
    get root_path
    assert_template 'chem_pages/home'
    assert_select "a[href=?]", root_path, count: 4
    assert_select "a[href=?]", help_path, count: 1
    assert_select "a[href=?]", login_path, count: 1
    assert_select "a[href=?]", about_path, count: 1
    assert_select "a[href=?]", contact_path, count: 1
    assert_select "a[href=?]", signup_path, count: 1
    assert_select "a[href=?]", quiz_types_path, count: 1
    assert_select "a[href=?]", quizzes_path, count: 1
    assert_select "a", count: 11
  end
  
end
