require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title, "Chemistry Quiz"
    assert_equal full_title("Help"), "Help | Chemistry Quiz"
  end
end