class Product < ActiveRecord::Base
  has_paper_trail :on => [:update, :destroy]
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

  require 'csv'

  def self.import(file, current_user)
    @products_imported = 0
    CSV.foreach(file, headers: true) do |row|
      if I18n.locale == :it
        self.create(
          initiative: row["Iniziativa"],
          local_code: row["Codice Locale"],
          description: row["Descrizione"],
          barcode: row["Codice a Barre"],
          default_price: row["Prezzo Continuo"],
          promo_price: row["Prezzo Promo"],
          quantity: row["Quantità"],
          status: row["Status"],
          arriving_date: row["Data Arrivo"],
          user: current_user
        )
        @products_imported += 1
      elsif I18n.locale = :en
        self.create(row.to_hash)
        @products_imported += 1
      end
    end
    @products_imported
  end

  private
  def arriving_status_validation
    if self.status == "arriving" && self.arriving_date == nil
      errors.add(:arriving_date, I18n.t('activerecord.errors.models.product.arriving_date'))
    end
  end

end
