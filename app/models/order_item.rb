class OrderItem < ActiveRecord::Base
  has_paper_trail :on => [:update, :destroy]
  belongs_to :order
  belongs_to :product
end
