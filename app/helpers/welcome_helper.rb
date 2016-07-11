module WelcomeHelper
  def product_status_label(product, arriving_date)
    if product.in_stock?
      # status = product.status.gsub(/_/, " ")
      if product.arriving_date == nil
        "<span class=\"label label-default pull-right\">#{t('recurring.in_stock')}</span>".html_safe
      else
        "<span class=\"label label-success pull-right\">#{t('recurring.in_stock')}</span>".html_safe
      end
    elsif product.arriving?
      if arriving_date >= Time.now
        "<span class=\"label label-warning pull-right\">#{t('recurring.arriving')}</span>".html_safe
      else
        "<span class=\"label label-danger pull-right\">#{t('recurring.delayed')}</span>".html_safe
      end
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
