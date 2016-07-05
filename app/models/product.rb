class Product < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  default_scope { order('initiative DESC') }

  enum status: [:in_stock, :arriving]
end
