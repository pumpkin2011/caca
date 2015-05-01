class AddFrozenAmountToUser < ActiveRecord::Migration
  def change
    add_column :users, :frozen_amount, :decimal, precision: 10, scale: 2,
                default: '0.00', after: :amount
  end
end
