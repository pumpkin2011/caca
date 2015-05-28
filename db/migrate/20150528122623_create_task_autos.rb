class CreateTaskAutos < ActiveRecord::Migration
  def change
    create_table :task_autos do |t|
      t.references :user, index: true
      t.references :template, index: true
      t.string :state, limit: 10
      t.integer :interval
      t.integer :total_count
      t.integer :process_count, default: 0
      t.integer :faild_count, default: 0
      t.datetime :next_at

      t.timestamps null: false
    end
    add_index :task_autos, :state
  end
end
