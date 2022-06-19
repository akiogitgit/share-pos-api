class Users < ActiveRecord::Migration[7.0]
  def change
    # drop_table :users
    # drop_table :posts
    drop_table :anpans
    drop_table :tokens
  end
end
