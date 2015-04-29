class AddStateToShop < ActiveRecord::Migration
  def change
    add_column :shops, :state, :string, limit: 10
    add_index :shops, :state
  end
end
