class CreateExtracts < ActiveRecord::Migration
  def change
    create_table :extracts do |t|
      t.references :user, index: true, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2
      t.string :channel, limit: 10
      t.string :sn, limit: 50
      t.string :state, limit: 10

      t.timestamps null: false
    end
    add_index :extracts, :channel
    add_index :extracts, :sn
    add_index :extracts, :state
  end
end
