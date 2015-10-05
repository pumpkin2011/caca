class AddCategoryToPages < ActiveRecord::Migration
  def change
    add_reference :pages, :category, index: true
  end
end
