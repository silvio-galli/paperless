class ChangeUsersEmail < ActiveRecord::Migration
  def change
    remove_column :users, :email
    add_column :users, :email, :string
  end
end
