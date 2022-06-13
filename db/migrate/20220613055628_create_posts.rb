class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :comment
      t.string :url, null:false
      t.boolean :published, default:false
      t.integer :evaluation, default:1

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
