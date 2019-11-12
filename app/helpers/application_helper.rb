module ApplicationHelper

  def full_title(page_title = '')
    base_title = "Chemistry Quiz"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

end
