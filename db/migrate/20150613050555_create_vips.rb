class CreateVips < ActiveRecord::Migration
  def change
    create_table :vips do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :pricing
      t.boolean :largess,default: false

      t.timestamps null: false
    end
  end
end
