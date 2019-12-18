require 'test_helper'

class PasswordResetsEditTest < ActionDispatch::IntegrationTest

  test "should get new password reset form" do
    get new_password_reset_path
    assert_select "title", "Forgot Password#{base_title}"
    assert_select "div.container" do
      assert_select "h1", "Forgot password"
      assert_select "div.row" do
        assert_select "form", count: 1 do
          assert_select "label", "Email", count: 1
          assert_select "input.form-control", count: 1
          assert_select "input.btn.btn-primary", count: 1
        end
      end
    end
  end
end
