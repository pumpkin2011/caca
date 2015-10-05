class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :account
      t.string :deposit
      t.string :front

      t.timestamps null: false
    end
  end
end
