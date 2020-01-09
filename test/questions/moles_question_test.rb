require 'test_helper'

class MolesQuestionTest < ActionDispatch::IntegrationTest

  test "should make moles question" do
    question = MolesQuestion.new.moles_question(1)
    assert_match (/How many moles of atoms are there in [\d.]+g of Helium[?]/), question[:prompt]
    assert_match (/[\d.]+/), question[:correct_answer]
    assert_equal question[:answers].count, 4
  end
  
  test "should make moles question answers" do
    question = MolesQuestion.new.moles_question(1)
    assert_equal question[:answers].count, 4
    assert_equal question[:answers].select{ |answer| answer == question[:correct_answer] }.count, 1
    assert_equal question[:answers].select{ |answer| answer != question[:correct_answer] }.count, 3
    question[:answers].each do |answer|
        assert_match (/[\d.]+/), answer
      end
  end

end
