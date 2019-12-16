require 'test_helper'

class LayoutsFooterTest < ActionView::TestCase
  
  test "should show footer" do
    render :partial => 'layouts/footer'
    assert_template partial: '_footer', count: 1
    assert_select "footer", count: 1 do
      assert_select "small", count: 1 do
        assert_select "a[href=?]", root_path, count: 1
      end
      assert_select "nav", count: 1 do
        assert_select "a[href=?]", about_path, count: 1
        assert_select "a[href=?]", contact_path, count: 1
      end
    end
    assert_select "a", count: 3
  end
end
