class Product < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  validates :description, presence: true
  validates :initiative, presence: true
  validates :barcode, presence: true
  validates :default_price, presence: true, unless: :promo_price
  validates :promo_price, presence: true, unless: :default_price
  validates :quantity,
                      presence: true,
                      numericality: { only_integer: true, less_than: 50 }
  validates :status, presence: true
  validate :arriving_status_validation

  default_scope { order('initiative DESC') }

  enum status: [:in_stock, :arriving]

  def is_arrived?
    previous_changes && previous_changes['status'] == ["arriving", "in_stock"]
  end

  private
  def arriving_status_validation
    if self.status == "arriving" && self.arriving_date == nil
      errors.add(:arriving_date, "cannot be blank if product has 'arriving' status")
    end
  end

end
