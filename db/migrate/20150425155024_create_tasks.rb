class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :user, index: true, foreign_key: true
      t.references :shop, index: true, foreign_key: true
      t.boolean :type
      t.string :link
      t.string :keywords
      t.decimal :price, precision: 10, scale: 2
      t.string :duration, limit: 10
      t.string :level, limit: 10
      t.string :chat, limit: 10
      t.string :desc
      t.string :spec
      t.boolean :receive_time
      t.boolean :comment_time
      t.string :comment
      t.string :extra, limit: 10
      t.string :state, limit: 10

      t.timestamps null: false
    end
    add_index :tasks, :duration
    add_index :tasks, :level
    add_index :tasks, :extra
    add_index :tasks, :state
  end
end
