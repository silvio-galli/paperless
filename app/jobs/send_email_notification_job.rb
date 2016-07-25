class SendEmailNotificationJob < ActiveJob::Base

  queue_as :default

  def perform(product)
    orders = product.orders.where(status: "open")
    orders.each do |order|
      ProductMailer.arrived_product_notice(product, order, order.customer).deliver_now
    end
  end
end
