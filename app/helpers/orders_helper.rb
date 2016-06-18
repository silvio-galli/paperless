module OrdersHelper
  def calculate_total_price(order)
    subtotal = order.order_items.map { |order_item| calculate_subtotal(order_item) }
    subtotal.sum
  end

  def calculate_total_items(order)
    items = order.order_items.map { |item| item.quantity }
    items.sum
  end
end
