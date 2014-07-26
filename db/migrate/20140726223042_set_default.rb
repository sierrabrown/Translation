class SetDefault < ActiveRecord::Migration
  def change
    change_column :jobs, :status, :string, default: "in progress"
    change_column :tasks, :status, :string, default: "in progress"
  end
end
