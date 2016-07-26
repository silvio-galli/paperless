class Order < ActiveRecord::Base
  has_paper_trail :on => [:update, :destroy]
  belongs_to :customer
  has_many :order_items
  has_many :products, through: :order_items

  enum status: [:open, :closed]

  default_scope { order("created_at DESC") }
  scope :open?, -> { where( status: 0 ) }

end
