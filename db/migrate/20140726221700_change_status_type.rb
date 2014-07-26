class ChangeStatusType < ActiveRecord::Migration
  def change
    rename_column :jobs, :completed, :status
    rename_column :tasks, :completed, :status
    
    change_column :jobs, :status, :string
    change_column :tasks, :status, :string
  end
end
