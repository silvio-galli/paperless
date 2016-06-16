module ProductsHelper
  def update_quantity(product)
    ordered_items = product.order_items.map { |item| item.quantity }
    product.quantity - ordered_items.sum
  end
end
