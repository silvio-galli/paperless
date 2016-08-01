class AddOrderItemOrderIdToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :order_item_order_id, :integer
  end
end
