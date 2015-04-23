class CreateDelivers < ActiveRecord::Migration
  def change
    create_table :delivers do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name, limit: 20, null: false
      t.string :phone, limit: 20, null: false
      t.string :province, limit: 6, null: false
      t.string :city, limit: 6, null: false
      t.string :district, limit: 6, null: false
      t.string :town, limit: 50
      t.string :address, limit: 100, null: false
      t.string :zip, limit: 6
      t.string :state, limit: 10, null: false

      t.timestamps null: false
    end
    add_index :delivers, :state
  end
end
