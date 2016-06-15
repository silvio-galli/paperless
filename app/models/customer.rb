class Customer < ActiveRecord::Base
  has_many :orders, dependent: :destroy

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
