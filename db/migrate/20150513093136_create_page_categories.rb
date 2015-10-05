class CreatePageCategories < ActiveRecord::Migration
  def change
    create_table :page_categories do |t|
      t.string :name, limit: 20

      t.timestamps null: false
    end
  end
end
