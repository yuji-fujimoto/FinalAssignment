class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :item_name
      t.integer :category
      t.string :brand
      t.string :size
      t.string :purchase_price
      t.text :remarks
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
