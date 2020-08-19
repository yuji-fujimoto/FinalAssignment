class AddMaxPantsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :max_pants, :integer
  end
end
