class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.references :wangwang, index: true, foreign_key: true
      t.references :task, index: true, foreign_key: true
      t.string :state, limit: 10

      t.timestamps null: false
    end
    add_index :orders, :state
  end
end
