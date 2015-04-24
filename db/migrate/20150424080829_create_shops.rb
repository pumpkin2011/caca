class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.references :user, index: true, foreign_key: true
      t.string :account, limit: 50

      t.timestamps null: false
    end
  end
end
