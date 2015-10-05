class CreatePictrues < ActiveRecord::Migration
  def change
    create_table :pictrues do |t|
      t.string :url
      t.references :imageable, polymorphic: true

      t.timestamps null: false
    end
  end
end
