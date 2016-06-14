class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :customer, index: true, foreign_key: true
      t.text :notes
      t.decimal :total_price

      t.timestamps null: false
    end
  end
end
