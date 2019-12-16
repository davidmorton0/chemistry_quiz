require 'test_helper'

class LayoutsShimTest < ActionView::TestCase
  
  test "should render shim" do
    partial = (render :partial => 'layouts/shim').split("\n")
    text = ['<!--[if lt IE 9]>', 
            '  <script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/r29/html5.min.js">',
            '  </script>',
            '<![endif]-->' ]
    (0..3).each do |n|
      assert_equal partial[n], text[n]
    end
  end
end