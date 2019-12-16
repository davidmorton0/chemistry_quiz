require 'test_helper'

class LayoutsHeaderTest < ActionView::TestCase
  
  test "should show header when logged in as admin" do
    @user = create(:new_user, :admin)
    log_in_as(@user)
    render :partial => 'layouts/header'
    assert_template partial: '_header', count: 1
    assert_select "header", count: 1
    assert_select "div", count: 1
    assert_select "nav", count: 1
    assert_select "li", count: 12
    assert_select "ul", count: 3
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", scores_path, count: 1
    assert_select "a[href=?]", help_path, count: 1
    assert_select "a[href=?]", user_path(@user), count: 1
    assert_select "a[href=?]", "#", count: 2
    assert_select "a[href=?]", users_path, count: 1
    assert_select "a[href=?]", quizzes_path, count: 1
    assert_select "a[href=?]", questions_path, count: 1
    assert_select "a[href=?]", edit_user_path(@user), count: 1
    assert_select "a[href=?]", logout_path, count: 1
    assert_select "a", count: 12
  end
  
  test "should show header when logged in as non-admin" do
    @user = create(:new_user)
    log_in_as(@user)
    render :partial => 'layouts/header'
    assert_template partial: '_header', count: 1
    assert_select "header", count: 1
    assert_select "div", count: 1
    assert_select "nav", count: 1
    assert_select "li", count: 8
    assert_select "ul", count: 2
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", scores_path, count: 1
    assert_select "a[href=?]", help_path, count: 1
    assert_select "a[href=?]", user_path(@user), count: 1
    assert_select "a[href=?]", "#", count: 1
    assert_select "a[href=?]", edit_user_path(@user), count: 1
    assert_select "a[href=?]", logout_path, count: 1
    assert_select "a", count: 8
  end
  
  test "should show header when logged out" do
    render :partial => 'layouts/header'
    assert_template partial: '_header', count: 1
    assert_select "header", count: 1
    assert_select "div", count: 1
    assert_select "nav", count: 1
    assert_select "li", count: 4
    assert_select "ul", count: 1
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", scores_path, count: 1
    assert_select "a[href=?]", help_path, count: 1
    assert_select "a[href=?]", login_path, count: 1
    assert_select "a", count: 5
  end
end
