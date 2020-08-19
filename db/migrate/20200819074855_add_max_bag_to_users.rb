class AddMaxBagToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :max_bag, :integer
  end
end
