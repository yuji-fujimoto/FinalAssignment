class AddMaxShoesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :max_shoes, :integer
  end
end
