require 'test_helper'

class LayoutsMailerTextTest < ActionView::TestCase
  
  test "shows mailer text" do
    text = render template: 'layouts/mailer.text'
    assert_equal text, ""
  end
  
end
