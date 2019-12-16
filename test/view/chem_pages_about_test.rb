require 'test_helper'

class ChemPagesAboutTest < ActionDispatch::IntegrationTest
  
  test "should show about page correctly" do
   get about_path
   assert_select "title", "About#{base_title}"
   assert_select "h1", text: /About/
   assert_select "p", text: /\w+/
  end
  
end
