class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  has_paper_trail
  has_paper_trail :meta => { :order_item_order_id  => :order_id }
end
