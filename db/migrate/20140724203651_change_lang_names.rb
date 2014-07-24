class ChangeLangNames < ActiveRecord::Migration
  def change
    rename_column :jobs, :source_lang_id, :source_lang
    rename_column :jobs, :target_lang_id, :target_lang
  end
end
