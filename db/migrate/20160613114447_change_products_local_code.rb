class ChangeProductsLocalCode < ActiveRecord::Migration
  def up
    change_table :products do |t|
      t.change :local_code, :string
    end
  end

  def down
    change_table :products do |t|
      t.change :local_code, :integer
    end
  end
end
