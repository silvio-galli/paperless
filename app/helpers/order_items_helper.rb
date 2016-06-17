module OrderItemsHelper
  def calculate_subtotal(order_item)
    promo_price = order_item.product.promo_price
    default_price = order_item.product.default_price
    quantity = order_item.quantity
    promo_price ? promo_price * quantity : default_price * quantity
  end
end
