class AddStateToDeposit < ActiveRecord::Migration
  def change
    add_column :deposits, :state, :string, limit: 10
    add_index :deposits, :state
  end
end
