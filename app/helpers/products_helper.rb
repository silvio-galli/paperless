module ProductsHelper
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
