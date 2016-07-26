class OrderItem < ActiveRecord::Base
  has_paper_trail
  belongs_to :order
  belongs_to :product
end
