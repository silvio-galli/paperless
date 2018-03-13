class AddArrivingDateToProducts < ActiveRecord::Migration
  def change
    add_column :products, :arriving_date, :datetime
  end
end
