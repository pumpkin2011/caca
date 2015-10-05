class CreateTaskTemplates < ActiveRecord::Migration
  def change
    create_table :task_templates do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name, limit: 20
      t.text :content

      t.timestamps null: false
    end
  end
end
