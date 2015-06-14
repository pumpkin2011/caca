class ChangeCodeToTask < ActiveRecord::Migration
  def change
    change_column :tasks, :code, :string, limit: 20, index: true

    Task.all.each do |t|
      t.code = "#{t.created_at.strftime('%y%m%d')}#{t.code}"
      t.save
    end
  end
end
