require 'test_helper'

class PasswordResetsNewTest < ActionDispatch::IntegrationTest

  test "should get edit password reset form" do
    @user = create(:new_user)
    @user.create_reset_digest
    get edit_password_reset_path(@user.reset_token, email: @user.email)
    assert_response :success
    assert_select "title", "Reset Password#{base_title}"
    assert_select "div.container" do
      assert_select "h1", "Reset Password"
      assert_select "div.row" do
        assert_select "div.col-md-6" do
          assert_select "form", count: 1 do
            assert_select "label", count: 2
            assert_select "label", "Password", count: 1
            assert_select "input", count: 5
            assert_select "input.form-control", count: 2
            assert_select "input.btn.btn-primary", count: 1
          end
        end
      end
    end
  end
  
end
