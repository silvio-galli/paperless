class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :order_items
  #has_many :ordered_products, through: :order_items, source: :product
end
