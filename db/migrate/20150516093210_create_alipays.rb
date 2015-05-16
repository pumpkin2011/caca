class CreateAlipays < ActiveRecord::Migration
  def change
    create_table :alipays do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :account

      t.timestamps null: false
    end
  end
end
