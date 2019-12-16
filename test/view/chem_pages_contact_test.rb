require 'test_helper'

class ChemPagesContactTest < ActionDispatch::IntegrationTest
  
  test "should show contact page correctly" do
   get contact_path
   assert_select "title", "Contact#{base_title}"
   assert_select "h1", text: /Contact/
   assert_select "p", text: /\w+/
  end
  
end
