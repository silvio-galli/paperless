module ProductsHelper

  def product_status_label(product, arriving_date)
    if product.in_stock?
      # status = product.status.gsub(/_/, " ")
      if product.arriving_date == nil
        "<span class=\"label label-default\">#{t('recurring.in_stock')}</span>".html_safe
      else
        "<span class=\"label label-success\">#{t('recurring.in_stock')}</span>".html_safe
      end
    elsif product.arriving?
      if arriving_date >= Time.now
        "<span class=\"label label-warning\">#{t('recurring.arriving')}</span>".html_safe
      else
        "<span class=\"label label-danger\">#{t('recurring.delayed')}</span>".html_safe
      end
    end
  end

  def available_items?(product)
    ordered_items = product.order_items.map { |item| item.quantity }
    available_items = product.quantity - ordered_items.sum
  end

  def check_product_availability(product)
    ordered_items = product.order_items.map { |item| item.quantity }
    available_items = product.quantity - ordered_items.sum
    if available_items <= 0
      "<span class=\"label label-default\">sold out</span>".html_safe
    else
      available_items
    end
  end

  def arrived_button(product)
    if product.arriving?
      link_to t('.arrived'), product_path(product, :product => {status: :in_stock}), method: :patch, class: 'btn btn-success btn-sm', data: { confirm: t('.arrived_product_confirmation') }
    else
      "&nbsp;".html_safe
    end
  end

end
