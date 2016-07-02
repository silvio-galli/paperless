class Product < ActiveRecord::Base
  has_many :order_items
  default_scope { order('initiative DESC') }

  enum status: [:in_stock, :arriving, :arrived]
end
