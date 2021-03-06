module OrdersHelper

  def order_status_label(order)
    if order.open?
      "<span class=\"label label-warning\">#{t('.open')}</span>".html_safe
    else
      "<span class=\"label label-primary\">#{t('.closed')}</span>".html_safe
    end
  end

  def calculate_total_price(order)
    subtotal = order.order_items.map { |order_item| calculate_subtotal(order_item) }
    subtotal.sum
  end

  def calculate_total_items(order)
    items = order.order_items.map { |item| item.quantity }
    items.sum
  end

  def close_button(order)
    if order.open?
      link_to t('.close'), order_path(order, :order => { status: :closed }), method: :patch, class: 'btn btn-success btn-sm', data: { confirm: t('.close_order_confirmation') }
    else
      "&nbsp;".html_safe
    end
  end
end
