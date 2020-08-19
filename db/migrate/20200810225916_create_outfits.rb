class CreateOutfits < ActiveRecord::Migration[5.2]
  def change
    create_table :outfits do |t|
      t.string :title
      t.string :concept
      t.integer :tops
      t.integer :outer
      t.integer :pants
      t.integer :bag
      t.integer :shoes
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
