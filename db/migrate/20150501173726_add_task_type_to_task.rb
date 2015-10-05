class AddTaskTypeToTask < ActiveRecord::Migration
  def change
    remove_column :tasks, :type
    add_column :tasks, :task_type, :string, limit: 10
    add_index :tasks, :task_type
  end
end
