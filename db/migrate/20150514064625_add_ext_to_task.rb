class AddExtToTask < ActiveRecord::Migration
  def change
    add_reference :tasks, :producer, index: true, after: :id
    add_reference :tasks, :consumer, index: true, after: :producer_id
    add_reference :tasks, :wangwang, index: true, after: :shop_id
    add_column :tasks, :ip, :string, limit: 20, after: :wangwang_id
    add_index :tasks, :ip
    remove_foreign_key :tasks, :user
    remove_reference :tasks, :user
  end
end
