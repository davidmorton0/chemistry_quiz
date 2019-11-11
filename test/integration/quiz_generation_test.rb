require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
end


=begin

    test "gets question data" do
    @question_data = question_data
    assert_match "What is the chemical symbol for", question_data[:question]
    question_data[:answers].each do |answer|
      assert answer.length > 0
      assert answer.length < 3
      assert_match /[A-Z][a-z]?/, answer
    end
  end
=end