class ProductMailerPreview < ActionMailer::Preview
  def arrived_product_notice
    product = Product.find(10)
    order = Order.find(9)
    customer = order.customer

    ProductMailer.arrived_product_notice(product, order, customer)
  end
end
