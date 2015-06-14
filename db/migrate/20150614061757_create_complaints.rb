class CreateComplaints < ActiveRecord::Migration
  def change
    create_table :complaints do |t|
      t.references :user, index: true, foreign_key: true
      t.references :target_user, index: true
      t.text :question
      t.text :answer
      t.string :state, limit: 10

      t.timestamps null: false
    end
    add_index :complaints, :state
  end
end
