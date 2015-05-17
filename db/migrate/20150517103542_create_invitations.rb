class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :user, index: true
      t.references :target, index: true
      t.datetime :confirmed_at

      t.timestamps null: false
    end
  end
end
