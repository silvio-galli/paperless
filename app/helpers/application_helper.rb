module ApplicationHelper
  def get_label_for(item)
    if item.count <= 0
      "<span class=\"label label-default\">#{item.count}</span>".html_safe
    elsif item.count > 0
      "<span class=\"label label-primary\">#{item.count}</span>".html_safe
    end
  end
end
