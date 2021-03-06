require 'test_helper'
class ChemPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = create(:new_user)
  end
  
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Home#{base_title}"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help#{base_title}"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About#{base_title}"
  end
  
  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact#{base_title}"
  end

end
