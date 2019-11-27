require 'test_helper'

class UsersHelperTest < ActionView::TestCase

  test "should format time correctly" do
    assert_equal format_time(45), "45s"
    assert_equal format_time(100), "1m 40s"
    assert_equal format_time(4000), "1h 6m 40s"
  end

end