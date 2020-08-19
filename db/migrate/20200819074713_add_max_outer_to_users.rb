class AddMaxOuterToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :max_outer, :integer
  end
end
