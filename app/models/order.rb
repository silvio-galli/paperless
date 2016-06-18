class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :order_items

  default_scope { order("created_at DESC") }
end
