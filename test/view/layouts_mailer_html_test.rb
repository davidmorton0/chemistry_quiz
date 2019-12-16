require 'test_helper'

class LayoutsMailerHtmlTest < ActionView::TestCase
  
  test "shows mailer html" do
    render template: 'layouts/mailer.html'
    assert_select "html", count: 1
    assert_select "head", count: 1
    assert_select "meta", count: 1
    assert_select "style", count: 1
    assert_select "body", count: 1
  end
end
