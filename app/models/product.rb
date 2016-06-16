class Product < ActiveRecord::Base
  has_many :order_items
  default_scope { order('initiative DESC') }
end
