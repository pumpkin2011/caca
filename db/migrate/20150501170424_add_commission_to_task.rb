class AddCommissionToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :commission, :decimal, precision: 10, scale: 2
    add_column :tasks, :commission_extra, :decimal, precision: 10, scale: 2
  end
end
