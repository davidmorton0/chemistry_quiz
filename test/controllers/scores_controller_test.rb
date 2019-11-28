require 'test_helper'

class ScoresControllerTest < ActionDispatch::IntegrationTest
  
  test "should get index" do
    get scores_path
    assert_response :success
  end
  
end
