require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
  end
  
  test "header links when logged in as admin" do
    @user = @admin
    log_in_as(@user)
    get root_path
    assert_template 'chem_pages/home'
    assert_template partial: '_header', count: 1
    assert_select "header" do
      assert_select "a[href=?]", root_path, count: 2
      assert_select "a[href=?]", help_path, count: 1
      assert_select "a[href=?]", user_path(@user), count: 1
      assert_select "a[href=?]", "#", count: 2
      assert_select "a[href=?]", users_path, count: 1
      assert_select "a[href=?]", questions_path, count: 1
      assert_select "a[href=?]", edit_user_path(@user), count: 1
      assert_select "a[href=?]", logout_path, count: 1
      assert_select "a", count: 10
    end
  end
  
  test "header links when logged in as non-admin" do
    @user = @non_admin
    log_in_as(@user)
    get root_path
    assert_template 'chem_pages/home'
    assert_template partial: '_header', count: 1
    assert_select "header" do
      assert_select "a[href=?]", root_path, count: 2
      assert_select "a[href=?]", help_path, count: 1
      assert_select "a[href=?]", user_path(@user), count: 1
      assert_select "a[href=?]", "#", count: 1
      assert_select "a[href=?]", edit_user_path(@user), count: 1
      assert_select "a[href=?]", logout_path, count: 1
      assert_select "a", count: 7
    end
  end
  
  test "header links when logged out" do
    delete logout_path
    get root_path
    assert_template 'chem_pages/home'
    assert_template partial: '_header', count: 1
    assert_select "header" do
      assert_select "a[href=?]", root_path, count: 2
      assert_select "a[href=?]", help_path, count: 1
      assert_select "a[href=?]", login_path, count: 1
      assert_select "a", count: 4
    end
  end

  test "footer links" do
    get root_path
    assert_template 'chem_pages/home'
    assert_template partial: '_footer', count: 1
    assert_select "footer" do
      assert_select "a[href=?]", root_path, count: 1
      assert_select "a[href=?]", about_path, count: 1
      assert_select "a[href=?]", contact_path, count: 1
      assert_select "a", count: 3
    end
  end
  
  test "main page links when logged in" do
    log_in_as(@non_admin)
    get root_path
    assert_template 'chem_pages/home'
    assert_template partial: '_head', count: 1
    assert_template partial: '_shim', count: 1
    assert_select "div.center" do
      assert_select "a[href=?]", quiz_types_path, count: 1
      assert_select "a[href=?]", quiz_path, count: 1
      assert_select "a", count: 2
    end
  end
  
  test "main page links when logged out" do
    delete logout_path
    get root_path
    assert_template 'chem_pages/home'
    assert_template partial: '_head', count: 1
    assert_template partial: '_shim', count: 1
    assert_select "div.center" do
      assert_select "a[href=?]", signup_path, count: 1
      assert_select "a", count: 1
    end
  end
end
