class ChangeOthertextColumns < ActiveRecord::Migration
  def change
    change_column :jobs, :machine_text, :text
    change_column :jobs, :target_text, :text
    
    change_column :tasks, :source_text, :text
    change_column :tasks, :machine_text, :text
    change_column :tasks, :target_text, :text
  end
end
