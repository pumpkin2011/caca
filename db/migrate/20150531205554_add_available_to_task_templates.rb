class AddAvailableToTaskTemplates < ActiveRecord::Migration
  def change
    add_column :task_templates, :available, :boolean
  end
end
