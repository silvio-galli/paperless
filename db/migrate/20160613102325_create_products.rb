class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :initiative
      t.integer :local_code
      t.string :description
      t.integer :barcode
      t.decimal :default_price, precision: 6, scale: 2
      t.decimal :promo_price, precision: 6, scale: 2
      t.integer :quantity
      t.integer :status

      t.timestamps null: false
    end
  end
end
