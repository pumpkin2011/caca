class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.references :user, index: true, foreign_key: true
      t.string :log
      t.decimal :amount, precision: 10, scale: 2
      t.string :state, limit: 20

      t.timestamps null: false
    end
    add_index :bills, :state
  end
end
