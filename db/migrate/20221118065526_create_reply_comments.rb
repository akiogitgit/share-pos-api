class CreateReplyComments < ActiveRecord::Migration[7.0]
  def change
    create_table :reply_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.string :body

      t.timestamps
    end
  end
end
