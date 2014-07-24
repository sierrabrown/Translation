class ChangeMisspelling < ActiveRecord::Migration
  def change
    rename_column :jobs, :macine_text, :machine_text
  end
end
