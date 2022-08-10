class AddPasswordToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :password_digest, :string, null: false
    add_column :users, :token, :string
    add_index :users, :token, unique: true
    remove_index :users, :email
    change_column :users, :email, :string, null: false, unique: true
  end
end
