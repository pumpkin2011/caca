class AddCodeToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :code, :string, limit: 7
    add_index :tasks, :code
  end
end
