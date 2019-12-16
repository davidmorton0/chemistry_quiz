require 'test_helper'

class ChemPagesHomeTest < ActionDispatch::IntegrationTest
  
  test "should show home page correctly when logged in" do
    @user = create(:new_user)
    log_in_as(@user)
    get root_path
    assert_select "title", "Home#{base_title}"
    assert_select "img", count: 1
    assert_match (/lab-[\w]+[.]jpg/), response.body
    assert_select "h1", text: "Chemistry Quiz"
    assert_select ".btn.btn-lg.btn-primary.home", count: 3 do
      assert_select "a[href=?]", scores_path, count: 1
      assert_select "a[href=?]", quiz_path, count: 1
      assert_select "a[href=?]", quiz_types_path, count: 1
    end
  end
  
  test "should show home page correctly when logged out" do
    get root_path
    assert_select "title", "Home#{base_title}"
    assert_select "img", count: 1
    assert_match (/lab-[\w]+[.]jpg/), response.body
    assert_select "h1", text: "Chemistry Quiz"
    assert_select ".btn.btn-lg.btn-primary.home", count: 2 do
      assert_select "a[href=?]", scores_path, count: 1
      assert_select "a[href=?]", signup_path, count: 1
    end
  end
end
