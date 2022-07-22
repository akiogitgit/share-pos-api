class CreateMetas < ActiveRecord::Migration[7.0]
  def change
    create_table :metas do |t|
      t.references :post, null: false, foreign_key: true
      t.string :image
      t.string :title

      t.timestamps
    end
  end
end
