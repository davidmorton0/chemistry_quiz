require 'test_helper'

class ChemPagesHelpTest < ActionDispatch::IntegrationTest
  
  test "should show help page correctly" do
   get help_path
   assert_select "title", "Help#{base_title}"
   assert_select "h1", text: /Help/
   assert_select "p", text: /\w+/
  end
  
end
