class RemoveEmailFromUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :email, :string, null:false
    remove_column :users, :tokens
  end
end
