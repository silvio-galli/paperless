class Customer < ActiveRecord::Base
  has_paper_trail
  has_many :orders, dependent: :destroy

  validates :last_name, presence: true
  validates :phone, presence: true
  validates :email, uniqueness: true

  default_scope { order("last_name ASC")}

  def full_name
    "#{self.last_name} #{self.first_name}"
  end
end
