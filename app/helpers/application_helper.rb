module ApplicationHelper
  
  # function to provide a title if one was not specified
  def page_title(title = '')
    standard_title = "Give Your Effort"
    if title.empty?
      standard_title
    else
      "#{title}"
    end
  end
  
end
