class AddVipToUser < ActiveRecord::Migration
  def change
    add_column :users, :vip_at, :datetime
  end
end
