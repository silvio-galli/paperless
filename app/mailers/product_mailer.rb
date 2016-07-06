class ProductMailer < ApplicationMailer
  default from: "shop_address@example.com"

  def arrived_product_notice(product, order, customer)
    @product = product
    @order = order
    @customer = customer

    mail(to: customer.email, subject: "Shop Name: Your Order (order n. #{order.id}) containing '#{product.description}' is ready.")
  end
end
