require 'test_helper'

class LayoutsHeadTest < ActionView::TestCase
  
  test "should return doument head" do
    render :partial => 'layouts/head'
    assert_select "head", count: 1
    assert_select "title", "Chemistry Quiz"
    assert_select "link"
    assert_select "script"
  end
end
