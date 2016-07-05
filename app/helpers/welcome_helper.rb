module WelcomeHelper
  def product_status_label(product, arriving_date)
    if product.in_stock?
      status = product.status.gsub(/_/, " ")
      "<span class=\"label label-default\">#{status}</span>".html_safe
    elsif product.arriving?
      if arriving_date >= Time.now
        "<span class=\"label label-warning\">#{product.status}</span>".html_safe
      else
        "<span class=\"label label-danger\">#{product.status}</span>".html_safe
      end
    else product.arrived?
      "<span class=\"label label-success\">#{product.status}</span>".html_safe
    end
  end

  def order_status_label(order)
    if order.open?
      "<span class=\"label label-warning\">#{order.status}</span>".html_safe
    else
      "<span class=\"label label-primary\">#{order.status}</span>".html_safe
    end
  end
end
