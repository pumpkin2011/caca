class AddExtendToBills < ActiveRecord::Migration
  def change
    add_column :bills, :total, :decimal, precision: 10, scale: 2
    add_column :bills, :process, :string, limit: 10
    add_index :bills, :process
  end
end
