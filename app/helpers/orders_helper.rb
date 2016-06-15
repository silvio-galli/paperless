module OrdersHelper
  def calculate_total_cost(order)
    subtotal_array = order.order_items.map { |item| calculate_subtotal(item) }
    subtotal_array.sum
  end
end
