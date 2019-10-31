require 'test_helper'

class ChemPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get chem_pages_home_url
    assert_response :success
  end

  test "should get help" do
    get chem_pages_help_url
    assert_response :success
  end

end
