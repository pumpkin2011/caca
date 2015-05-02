class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :number
      t.string :front
      t.string :back
      t.string :handheld

      t.timestamps null: false
    end
  end
end
