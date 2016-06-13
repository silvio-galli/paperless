class ChangeProductsBarcode < ActiveRecord::Migration
  def up
    change_table :products do |t|
      t.change :barcode, :string
    end
  end

  def down
    change_table :products do |t|
      t.change :barcode, :integer
    end
  end
end
