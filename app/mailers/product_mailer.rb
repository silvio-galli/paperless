class ProductMailer < ApplicationMailer
  default from: "shop_address@example.com",
          cc: ENV['CC_EMAIL']

  def arrived_product_notice(product, order, customer)
    @product = product
    @order = order
    @customer = customer
    @arriving_items = @order.order_items.select { |item| item.product.arriving? }

    if @arriving_items.empty?
      mail(to: customer.email, subject: t('.order_subject'))
    else
      mail(to: customer.email, subject: t('.product_subject'))
    end
  end

end
