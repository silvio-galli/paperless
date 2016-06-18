class RemoveCustomerFromOrderItems < ActiveRecord::Migration
  def change
    remove_column :order_items, :customer_id, :integer
  end
end
