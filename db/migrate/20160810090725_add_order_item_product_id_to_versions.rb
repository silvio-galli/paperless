class AddOrderItemProductIdToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :order_item_product_id, :integer
  end
end
