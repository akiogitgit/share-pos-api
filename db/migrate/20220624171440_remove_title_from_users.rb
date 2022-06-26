class RemoveTitleFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :nickname, :string
    change_column :users, :email, :string, null:false
    change_column :users, :username, :string, null:false
  end
end
