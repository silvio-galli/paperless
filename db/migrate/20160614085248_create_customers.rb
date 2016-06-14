class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.string :address
      t.string :postcode
      t.string :city
      t.string :country

      t.timestamps null: false
    end
  end
end
