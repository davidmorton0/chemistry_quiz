require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

=begin

test "should show results at end of test" do
    post quiz_path,
      params: { quiz: {"question_number"=>"10", "page"=>"answer", "score"=>"2"} }
    assert_response :success
    assert_no_match '✔️', response.body
    assert_no_match '❌', response.body
    assert_select "input[type=?]", 'radio', count: 0
    assert_match 'You scored 2 out of 10', response.body
  end
  
=end

end
