class ProductMailer < ApplicationMailer
  default from: "shop_address@example.com",
          cc: ENV['CC_EMAIL']

  def arrived_product_notice(product, order, customer)
    @product = product
    @order = order
    @customer = customer

    mail(to: customer.email, subject: "test email from paperless - The product you ordered has arrived at SHOP_NAME")
  end

end
