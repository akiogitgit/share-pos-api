class CreateMetaInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :meta_infos do |t|
      t.references :post, null: false, foreign_key: true
      t.string :image
      t.string :title

      t.timestamps
    end
  end
end
