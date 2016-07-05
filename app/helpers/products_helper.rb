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

end
