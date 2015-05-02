class AddStateToUser < ActiveRecord::Migration
  def change
    add_column :users, :state, :string, limit: 10
    add_index :users, :state
  end
end
