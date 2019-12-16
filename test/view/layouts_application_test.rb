require 'test_helper'

class LayoutsApplicationTest < ActionView::TestCase
  
  test "should show layout" do
    render template: 'layouts/application'
    assert_select "html", count: 1
    assert_template partial: '_head', count: 1
    assert_select "body", count: 1
    assert_template partial: '_header', count: 1
    assert_select "div", count: 2
    assert_template partial: '_footer', count: 1
  end
  
  test "should not show flash if empty" do
    flash = nil
    render template: 'layouts/application'
    assert_select "div.alert", count: 0
  end
  
  test "should show info flash message" do
    flash[:info] = "Info"
    render template: 'layouts/application'
    assert_select "div.alert.alert-info", "Info", count: 1
  end
  
  test "should show 2 flash messages" do
    flash[:danger] = "Danger"
    flash[:info] = "Info"
    render template: 'layouts/application'
    assert_select "div.alert", count: 2
    assert_select "div.alert.alert-danger", "Danger", count: 1
    assert_select "div.alert.alert-info", "Info", count: 1
  end
  
  test "should replace flash message with another" do
    flash[:info] = "Danger"
    flash[:info] = "Info"
    render template: 'layouts/application'
    assert_select "div.alert", count: 1
    assert_select "div.alert.alert-info", "Info", count: 1
  end
end
