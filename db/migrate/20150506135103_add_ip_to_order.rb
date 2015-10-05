class AddIpToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :ip, :string, limit: 20
    add_index :orders, :ip
  end
end
