class ProductMailer < ApplicationMailer
  default from: "shop_address@example.com",
          cc: ENV['CC_EMAIL']

  def arrived_product_notice(product, order, customer)
    @product = product
    @order = order
    @customer = customer
    @arriving_items = @order.order_items.select { |item| item.product.arriving? }

    if @arriving_items.empty?
      mail(to: customer.email, subject: "Your order is ready at SHOP_NAME")
    else
      mail(to: customer.email, subject: "The product you ordered has arrived at SHOP_NAME")
    end
  end

end
