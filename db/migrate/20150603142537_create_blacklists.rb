class CreateBlacklists < ActiveRecord::Migration
  def change
    create_table :blacklists do |t|
      t.references :user, index: true
      t.references :target, index: true
      t.string :question

      t.timestamps null: false
    end
  end
end
