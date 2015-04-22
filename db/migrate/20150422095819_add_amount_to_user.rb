class AddAmountToUser < ActiveRecord::Migration
  def change
    add_column :users, :amount, :decimal, precision: 10, scale: 2, default: '0.00', after: :email
  end
end
