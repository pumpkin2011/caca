class CreateDeposits < ActiveRecord::Migration
  def change
    create_table :deposits do |t|
      t.references :user, index: true, foreign_key: true
      t.references :admin, index: true, foreign_key: true
      t.string :sn, limit: 32
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps null: false
    end
    add_index :deposits, :sn, unique: true
  end
end
