class CreateWangwangs < ActiveRecord::Migration
  def change
    create_table :wangwangs do |t|
      t.references :user, index: true, foreign_key: true
      t.string :account, limit: 50
      t.string :state, limit: 10

      t.timestamps null: false
    end
    add_index :wangwangs, :state
  end
end
