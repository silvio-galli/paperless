module OrderItemsHelper
  def calculate_subtotal(item)
    promo_price = item.product.promo_price
    default_price = item.product.default_price
    quantity = item.quantity
    promo_price ? promo_price * quantity : default_price * quantity
  end
end
