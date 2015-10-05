class AddExtendToComplaints < ActiveRecord::Migration
  def change
    add_reference :complaints, :task, index: true, foreign_key: true
    add_column :complaints, :reason, :string, limit: 20
  end
end
