class FixTaskColumns < ActiveRecord::Migration
  def change
    rename_column :tasks, :source_lang_id, :source_lang
    rename_column :tasks, :target_lang_id, :target_lang
    rename_column :tasks, :macine_text, :machine_text
    
    change_column :tasks, :source_lang, :string
    change_column :tasks, :target_lang, :string
  end
end
