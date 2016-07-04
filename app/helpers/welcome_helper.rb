module WelcomeHelper
  def get_status_label(status, arriving_date)
    if status == "in_stock"
      status = status.gsub(/_/, " ")
      "<span class=\"label label-default\">#{status}</span>".html_safe
    elsif status == "arriving"
      if arriving_date >= Time.now
        "<span class=\"label label-warning\">#{status}</span>".html_safe
      else
        "<span class=\"label label-danger\">#{status}</span>".html_safe
      end
    else status == "arrived"
      "<span class=\"label label-success\">#{status}</span>".html_safe
    end
  end
end
