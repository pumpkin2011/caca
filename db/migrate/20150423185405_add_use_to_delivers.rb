class AddUseToDelivers < ActiveRecord::Migration
  def change
    add_reference :delivers, :owner, index: true, after: :user_id
    add_foreign_key :delivers, :users, column: :owner_id
  end
end
