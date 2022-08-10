class RemoveDeviseFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :provider
    remove_column :users, :uid
    remove_column :users, :encrypted_password
    remove_column :users, :reset_password_toke
    remove_column :users, :reset_password_sent_a
    remove_column :users, :allow_password_change
    remove_column :users, :remember_created_a
    remove_column :users, :confirmation_toke
    remove_column :users, :confirmed_a
    remove_column :users, :confirmation_sent_a
    remove_column :users, :unconfirmed_emai
  end
end
