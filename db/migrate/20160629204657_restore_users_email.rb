class RestoreUsersEmail < ActiveRecord::Migration
  def change
    remove_column :users, :email, :string
    add_column :users, :email, :string, { default: "", null: false }
  end
end
