class AddCoverToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :cover, :string
  end
end
