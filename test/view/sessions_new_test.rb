require 'test_helper'

class SessionsNewTest < ActionDispatch::IntegrationTest
  
  test "should get login form" do
    get login_path
    assert_select "title", "Log in#{base_title}"
    assert_select "div.container" do
      assert_select "h1", "Log in"
      assert_select "div.row" do
        assert_select "div.col-md-6.col-md-offset-3" do
          assert_select "form", count: 1 do
            assert_select "label", "Email", count: 1
            assert_select "input#session_email", count: 1
            assert_select "label", "Password", count: 1
            assert_select "input#session_password", count: 1
            assert_select "label.checkbox.inline", count: 1 do
              assert_select "input", count: 2
              assert_select "span", "Remember me on this computer", count: 1
            end
            assert_select "input.btn.btn-primary", count: 1
          end
          assert_select 'p', 'New user? Sign up now!' do
            assert_select "a[href=?]", signup_path, "Sign up now!"
          end
        end
      end
    end
  end
  
end
