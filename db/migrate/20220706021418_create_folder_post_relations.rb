class CreateFolderPostRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :folder_post_relations do |t|
      t.references :folder, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
