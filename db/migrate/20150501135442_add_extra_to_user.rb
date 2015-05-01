class AddExtraToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, limit: 20, after: :email
    add_column :users, :qq, :string, limit: 15, after: :name
    add_index :users, :qq

    add_index :users, :name
  end
end
