require 'test_helper'
class ChemPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title = " | Chemistry Quiz"
  end

  test "should get root" do
    get chem_pages_home_url
    assert_response :success
  end

  test "should get home" do
    get chem_pages_home_url
    assert_response :success
    assert_select "title", "Home#{@base_title}"
  end

  test "should get help" do
    get chem_pages_help_url
    assert_response :success
    assert_select "title", "Help#{@base_title}"
  end

  test "should get about" do
    get chem_pages_about_url
    assert_response :success
    assert_select "title", "About#{@base_title}"
  end

end
