class Customer < ActiveRecord::Base
  has_many :orders, dependent: :destroy

  default_scope { order("last_name ASC")}

  def full_name
    "#{self.last_name} #{self.first_name}"
  end
end
